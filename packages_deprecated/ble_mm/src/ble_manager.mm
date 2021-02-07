#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include "ble_manager.h"
#include "objc_cpp.h"

@implementation BLEManager
- (instancetype)init: (const Napi::Value&) receiver with: (const Napi::Function&) callback {
    if (self = [super init]) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (Napi::Value)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates {
    return Napi::Value();
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn ){
        NSLog(@"poweredOn");
    } else {
        NSLog(@"poweredOff");
    }
}

+ (Napi::Object)getClass: (Napi::Env) env exports: (Napi::Object)exports {
    Napi::String name = Napi::String::New(env, "BLEManager");
    Napi::Function func = DefineClass(env, "BLEManager", {
        BLEManager::InstanceMethod("startScanning", &BLEManager::scan),
    });
    exports.Set(name, func);
    return exports;
}

@end
