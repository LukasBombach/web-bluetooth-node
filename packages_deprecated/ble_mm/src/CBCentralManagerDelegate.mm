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
    centralManager = [[CBCentralManager alloc] initWithDelegate:this queue:nil];
}

Napi::Value CBCentralManagerDelegate::Scan(const Napi::CallbackInfo& info) {
    [centralManager scan:nil allowDuplicates:YES];
    return Napi::Value();
}
