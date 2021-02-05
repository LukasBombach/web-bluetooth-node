#import <Foundation/Foundation.h>
#include "main.interface.h"
#include "ble_manager.h"

int logHelloWorld() {
    BLEManager* manager = [[BLEManager alloc] init];
    [manager startScan];
    [manager release];
    return 42;
}
