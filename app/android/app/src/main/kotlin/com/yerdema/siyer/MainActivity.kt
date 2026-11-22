package com.yerdema.siyer

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var paketler: BolumPaketleri? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        paketler = BolumPaketleri(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy() {
        paketler?.kapat()
        paketler = null
        super.onDestroy()
    }
}
