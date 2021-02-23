#pragma once

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <napi.h>
#include "emit.h"

@interface BLEManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
    Emit emit;
}

@property (strong) CBCentralManager *centralManager;
@property dispatch_queue_t dispatchQueue;

- (instancetype)init: (const Napi::Value&) receiver with: (const Napi::Function&) callback;
- (void)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates;

@end
