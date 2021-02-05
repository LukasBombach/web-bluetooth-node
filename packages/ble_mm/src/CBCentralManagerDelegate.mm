#include "CBCentralManagerDelegate.h"

Napi::FunctionReference CBCentralManagerDelegate::constructor;

Napi::Object CBCentralManagerDelegate::Init(Napi::Env env, Napi::Object exports) {
  Napi::HandleScope scope(env);
  
  Napi::Function func = DefineClass(env, "CBCentralManagerDelegate", {
  });

  constructor = Napi::Persistent(func);
  constructor.SuppressDestruct();

  exports.Set("CBCentralManagerDelegate", func);
  return exports;
}

CBCentralManagerDelegate::CBCentralManagerDelegate(const Napi::CallbackInfo& info): Napi::ObjectWrap<CBCentralManagerDelegate>(info)  {
}

