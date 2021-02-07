#include "cb_delegate.h"

@implementation CBDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
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
