#pragma once

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <dispatch/dispatch.h>

#include "callbacks.h"

@interface BLEManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
    Emit emit;
}

@property (strong) CBCentralManager *centralManager;

+ (Napi::Object)getClass: (Napi::Env) env exports: (Napi::Object)exports;
- (instancetype)init: (const Napi::Value&) receiver with: (const Napi::Function&) callback;
- (Napi::Value)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates;

@end
