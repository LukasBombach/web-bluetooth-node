#pragma once

#include <napi.h>
#include "ble_manager.h"

class CPPBridge : public Napi::ObjectWrap<CPPBridge> {
    public:
        static Napi::Object Init(Napi::Env env, Napi::Object exports);
        CPPBridge(const Napi::CallbackInfo& info);
        Napi::Value Scan(const Napi::CallbackInfo& info);

    private:
        static Napi::FunctionReference constructor;
        BLEManager* manager;
};
