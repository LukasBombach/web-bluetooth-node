#pragma once

#include <napi.h>
#include "cb_delegate.h"

class CPPBridge : public Napi::ObjectWrap<CPPBridge>
{
public:
    CPPBridge(const Napi::CallbackInfo&);
    Napi::Value Init(const Napi::CallbackInfo&);

    static Napi::Function GetClass(Napi::Env);

private:
    CBDelegate* cbDelegate;
};
