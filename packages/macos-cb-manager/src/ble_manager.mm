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
    NSMutableArray* advServicesUuid = [NSMutableArray arrayWithCapacity:[serviceUUIDs count]];
    [serviceUUIDs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [advServicesUuid addObject:[CBUUID UUIDWithString:obj]];
    }];
    NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:allowDuplicates]};
    [self.centralManager scanForPeripheralsWithServices:advServicesUuid options:options];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn ){
        NSLog(@"poweredOn");
        emit.RadioMessage("poweredOn");

    } else {
        NSLog(@"poweredOff");
        emit.RadioMessage("poweredOff");

    }
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    emit.RadioMessage("got peripheral");
}

@end
