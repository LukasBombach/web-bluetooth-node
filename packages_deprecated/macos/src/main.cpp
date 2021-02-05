#include <napi.h>
#include "functionexample.h"

using namespace Napi;

Napi::Object Init(Napi::Env env, Napi::Object exports) {
  return functionexample::Init(env, exports);
}

NODE_API_MODULE(addon, Init)

