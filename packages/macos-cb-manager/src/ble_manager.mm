#include "ble_manager.h"

@implementation BLEManager

- (instancetype)init: (const Napi::Value&) receiver with: (const Napi::Function&) callback {
    if (self = [super init]) {
        self->emit.Wrap(receiver, callback);
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
        emit.RadioState("poweredOn");
    } else {
        NSLog(@"poweredOff");
        emit.RadioState("poweredOff");
    }
}

@end
