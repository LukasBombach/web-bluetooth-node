{
    "targets": [
        {
            'target_name': 'ble_mm',
            'sources': ['src/napi_objc.mm', 'src/ble_manager.mm', 'src/objc_cpp.mm', 'src/callbacks.cc'],
            'cflags!': ['-fno-exceptions'],
            'cflags_cc!': ['-fno-exceptions'],
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
                'MACOSX_DEPLOYMENT_TARGET': '10.7'
            },
            'msvs_settings': {
                'VCCLCompilerTool': {'ExceptionHandling': 1},
            },
        }
    ]
}
