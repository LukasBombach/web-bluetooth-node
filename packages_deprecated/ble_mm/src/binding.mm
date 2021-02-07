#include <napi.h>
#include "ble_manager.h"

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    // BLEManager::init(env, exports);
    [BLEManager getClass];
    return exports;
}

NODE_API_MODULE(NODE_GYP_MODULE_NAME, Init)