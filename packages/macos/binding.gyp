{
    'targets': [
        {
            'target_name': 'web-bluetooth-macos',
            "sources": [
                "src/main.cpp",
                "src/functionexample.cpp",
                "src/objc.interface.h",
                "src/objc.mm",
                "src/CoreBluetooth/main.interface.h",
                "src/CoreBluetooth/main.mm",
                "src/CoreBluetooth/ble_manager.h",
                "src/CoreBluetooth/ble_manager.mm"
            ],
            'include_dirs': ["<!@(node -p \"require('node-addon-api').include\")"],
            'dependencies': ["<!(node -p \"require('node-addon-api').gyp\")"],
            'cflags!': ['-fno-exceptions'],
            'cflags_cc!': ['-fno-exceptions'],
            'xcode_settings': {
                'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
                'CLANG_CXX_LIBRARY': 'libc++',
                'MACOSX_DEPLOYMENT_TARGET': '10.7'
            },
            'msvs_settings': {
                'VCCLCompilerTool': {'ExceptionHandling': 1},
            },
            'link_settings': {
                'libraries': [
                    '$(SDKROOT)/System/Library/Frameworks/Foundation.framework',
                    '$(SDKROOT)/System/Library/Frameworks/CoreBluetooth.framework',
                ]
            }
        }
    ]
}
