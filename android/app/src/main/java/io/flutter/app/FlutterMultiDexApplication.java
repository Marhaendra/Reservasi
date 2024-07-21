package io.flutter.app;

import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class FlutterMultiDexApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        MultiDex.install(this);
    }
}
