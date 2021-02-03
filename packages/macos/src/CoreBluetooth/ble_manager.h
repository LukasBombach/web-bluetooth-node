#pragma once

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEManager : NSObject <CBCentralManagerDelegate>;
@property (strong) CBCentralManager *centralManager;

- (void) startScan;
- (void) stopScan;

@end



