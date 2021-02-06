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

Napi::Value NobleMac::Scan(const Napi::CallbackInfo& info) {
    CHECK_MANAGER()
    NSArray* array = getUuidArray(info[0]);
    // default value NO
    auto duplicates = getBool(info[1], NO);
    [manager scan:array allowDuplicates:duplicates];
    return Napi::Value();
}

