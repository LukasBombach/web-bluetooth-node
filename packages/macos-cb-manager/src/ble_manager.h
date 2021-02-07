#pragma once

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <napi.h>

@interface BLEManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {}

@property (strong) CBCentralManager *centralManager;
@property dispatch_queue_t dispatchQueue;

- (instancetype)init;
- (void)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates;

@end
