#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include "ble_manager.h"

@implementation BLEManager
- (instancetype)init
{
  if (self = [super init]) {
      self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
      
  }
  return self;
}

- (void) startScan 
{
  @autoreleasepool {  
    NSLog(@"startScan");
  }
  [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void) stopScan 
{
  @autoreleasepool {  
    NSLog(@"stopScan");
  }
  [self.centralManager stopScan];
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)aPeripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI 
{    
  @autoreleasepool {  
    NSLog(@"Found peripheral");
  }
}

-(void) centralManagerDidUpdateState:(CBCentralManager *)central {
  @autoreleasepool {  
    NSLog(@"updated state");
  }
}

@end