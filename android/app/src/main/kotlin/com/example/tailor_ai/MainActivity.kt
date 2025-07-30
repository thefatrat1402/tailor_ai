package com.example.arheight

import android.os.Bundle
import android.view.MotionEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.ar.core.*
import com.google.ar.core.exceptions.*
import com.google.ar.sceneform.ux.ArFragment
import com.google.ar.sceneform.ux.TransformableNode
import com.google.ar.sceneform.AnchorNode
import com.google.ar.sceneform.rendering.Color
import com.google.ar.sceneform.rendering.MaterialFactory
import com.google.ar.sceneform.rendering.ModelRenderable
import com.google.ar.sceneform.rendering.ShapeFactory

class MainActivity : FlutterActivity() {
  private val CHANNEL = "com.example.arheight/height"
  private var headPose: Pose? = null
  private var footPose: Pose? = null

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "startHeightEstimation") {
        runOnUiThread {
          setupTapBasedEstimation(result)
        }
      } else {
        result.notImplemented()
      }
    }
  }
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
  }
  private fun setupTapBasedEstimation(result: MethodChannel.Result) {
    val arFragment = supportFragmentManager.findFragmentById(R.id.ar_fragment) as ArFragment?
    if (arFragment == null) {
      result.error("NO_AR_FRAGMENT", "AR fragment not found", null)
      return
    }

    arFragment.setOnTapArPlaneListener { hitResult, _, _ ->
      if (headPose == null) {
        headPose = hitResult.hitPose
      } else if (footPose == null) {
        footPose = hitResult.hitPose
        val height = Math.abs(headPose!!.ty() - footPose!!.ty())
        result.success(height.toDouble())
        headPose = null
        footPose = null
      }
    }
  }
}
