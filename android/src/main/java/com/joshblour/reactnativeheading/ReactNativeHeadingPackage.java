package com.joshblour.reactnativeheading;

import android.app.Activity;
import android.app.Application;

import androidx.annotation.Nullable;
import com.facebook.react.TurboReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReactNativeHeadingPackage extends TurboReactPackage {

    public ReactNativeHeadingPackage() {}

    @Nullable
    @Override
    public NativeModule getModule(String name, ReactApplicationContext reactContext) {
        if (name.equals(ReactNativeHeadingModule.NAME)) {
            return new ReactNativeHeadingModule(reactContext);
        }
        return null;
    }

    @Override
    public ReactModuleInfoProvider getReactModuleInfoProvider() {
        return () -> {
            Map<String, ReactModuleInfo> map = new HashMap<>();
            map.put(ReactNativeHeadingModule.NAME,
                new ReactModuleInfo(
                ReactNativeHeadingModule.NAME,
                ReactNativeHeadingModule.NAME,
                false, // canOverrideExistingModule
                false, // needsEagerInit
                false,  // hasConstants
                false, // isCxxModule
                true   // isTurboModule
                )
            );
            return map;
        };
    }

    // Deprecated RN 0.47
    public List<Class<? extends JavaScriptModule>> createJSModules() {
        return Collections.emptyList();
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Arrays.asList();
    }
}
