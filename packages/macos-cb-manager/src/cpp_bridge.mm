#include "ble_manager.h"
#include "cpp_bridge.h"


Napi::FunctionReference CPPBridge::constructor;

Napi::Object CPPBridge::Init(Napi::Env env, Napi::Object exports) {
    Napi::HandleScope scope(env);
    Napi::Function func = DefineClass(env, "CPPBridge", {
        // InstanceMethod("init", &CPPBridge::Init),
    });
    constructor = Napi::Persistent(func);
    constructor.SuppressDestruct();
    exports.Set("CPPBridge", func);
    return exports;
}

CPPBridge::CPPBridge(const Napi::CallbackInfo& info)
: Napi::ObjectWrap<CPPBridge>(info)  {
    Napi::Function emit = info.This().As<Napi::Object>().Get("emit").As<Napi::Function>();
    manager = [[BLEManager alloc] init:info.This() with:emit];
}

// startScanning(serviceUuids, allowDuplicates)
Napi::Value CPPBridge::Scan(const Napi::CallbackInfo& info) {
    NSArray* array = nil; // getUuidArray(info[0]);
    auto duplicates = YES; // getBool(info[1], NO);
    [manager scan:array allowDuplicates:duplicates];
    return Napi::Value();
}

/* Napi::Value CPPBridge::Init(const Napi::CallbackInfo& info) {
    Napi::Function emit = info.This().As<Napi::Object>().Get("emit").As<Napi::Function>();
    manager = [[BLEManager alloc] init:info.This() with:emit];
    return Napi::Value();
} */

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    CPPBridge::Init(env, exports);
    return exports;
}


NODE_API_MODULE(addon, Init)

// CPPBridge::CPPBridge(const Napi::CallbackInfo& info) : ObjectWrap(info) {
// }

// Napi::Function CPPBridge::GetClass(Napi::Env env) {
//     return DefineClass(env, "CBManager", {
//         CPPBridge::InstanceMethod("init", &CPPBridge::Init),
//     });
// }

// Napi::Object Init(Napi::Env env, Napi::Object exports) {
//     Napi::String name = Napi::String::New(env, "CPPBridge");
//     exports.Set(name, CPPBridge::GetClass(env));
//     return exports;
// }

