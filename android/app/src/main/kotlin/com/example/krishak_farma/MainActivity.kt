package com.example.krishak_farma
import io.flutter.embedding.android.SplashScreen
import com.example.krishak_farma.SplashView // Make sure the package path is correct
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun provideSplashScreen(): SplashScreen? = SplashView()
}
