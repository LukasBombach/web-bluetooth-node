#include "ble_manager.h"
#include "cpp_bridge.h"

CPPBridge::CPPBridge(const Napi::CallbackInfo& info) : ObjectWrap(info) {
}

Napi::Value CPPBridge::Init(const Napi::CallbackInfo& info) {
    manager = [[BLEManager alloc] init];
    return Napi::Value();
}

Napi::Function CPPBridge::GetClass(Napi::Env env) {
    return DefineClass(env, "CBManager", {
        CPPBridge::InstanceMethod("init", &CPPBridge::Init),
    });
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    Napi::String name = Napi::String::New(env, "CPPBridge");
    exports.Set(name, CPPBridge::GetClass(env));
    return exports;
}

NODE_API_MODULE(addon, Init)
