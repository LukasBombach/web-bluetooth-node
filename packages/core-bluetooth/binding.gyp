{
    "targets": [
        {
            'target_name': 'ble_mm',
            'sources': ["src/ble_manager.mm", "src/cpp_bridge.mm", "src/emit.cc"],
            'cflags!': ['-fno-exceptions'],
            'cflags_cc!': ['-fno-exceptions'],
            'include_dirs': ["<!@(node -p \"require('node-addon-api').include\")"],
            'include_dirs': ["<!@(node -p \"require('node-addon-api').include\")", "<!@(node -p \"require('napi-thread-safe-callback').include\")"],
            'dependencies': ["<!(node -p \"require('node-addon-api').gyp\")"],
            'link_settings': {
                'libraries': [
                    '$(SDKROOT)/System/Library/Frameworks/Foundation.framework',
                    '$(SDKROOT)/System/Library/Frameworks/CoreBluetooth.framework',
                ]
            },
            'xcode_settings': {
                'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
                'CLANG_CXX_LIBRARY': 'libc++',
                'MACOSX_DEPLOYMENT_TARGET': '10.13'
            },
            'msvs_settings': {
                'VCCLCompilerTool': {'ExceptionHandling': 1},
            },
        }
    ]
}
