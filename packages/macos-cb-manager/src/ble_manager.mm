#include "ble_manager.h"

@implementation BLEManager

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create("CBQueue", 0);
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.dispatchQueue];
    }
    return self;
}

- (void)scan: (NSArray<NSString*> *)serviceUUIDs allowDuplicates: (BOOL)allowDuplicates {
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn ){
        NSLog(@"poweredOn");
    } else {
        NSLog(@"poweredOff");
    }
}

@end
