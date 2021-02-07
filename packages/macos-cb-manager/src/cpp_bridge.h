#pragma once

#include <napi.h>
#include "ble_manager.h"

class CPPBridge : public Napi::ObjectWrap<CPPBridge>
{
public:
    CPPBridge(const Napi::CallbackInfo&);
    Napi::Value Init(const Napi::CallbackInfo&);

    static Napi::Function GetClass(Napi::Env);

private:
    BLEManager* manager;
};
