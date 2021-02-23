#include "ble_manager.h"
#include "cpp_bridge.h"


Napi::FunctionReference CPPBridge::constructor;

Napi::Object CPPBridge::Init(Napi::Env env, Napi::Object exports) {
    Napi::HandleScope scope(env);
    Napi::Function func = DefineClass(env, "CPPBridge", {
        CPPBridge::InstanceMethod("scan", &CPPBridge::Scan),
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

Napi::Value CPPBridge::Scan(const Napi::CallbackInfo& info) {
    NSArray* array = nil;
    auto duplicates = YES;
    [manager scan:array allowDuplicates:duplicates];
    return Napi::Value();
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    CPPBridge::Init(env, exports);
    return exports;
}

NODE_API_MODULE(addon, Init)
