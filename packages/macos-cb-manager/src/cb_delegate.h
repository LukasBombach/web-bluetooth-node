#pragma once

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <napi.h>

@interface CBDelegate : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {}

@property (strong) CBCentralManager *centralManager;

- (instancetype)init;
- (void)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates;

@end
