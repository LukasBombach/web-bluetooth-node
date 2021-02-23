#include "emit.h"
#include <napi-thread-safe-callback.hpp>

#define _s(val) Napi::String::New(env, val)
#define _b(val) Napi::Boolean::New(env, val)
#define _n(val) Napi::Number::New(env, val)
#define _u(str) toUuid(env, str)

void Emit::Wrap(const Napi::Value& receiver, const Napi::Function& callback) {
    mCallback = std::make_shared<ThreadSafeCallback>(receiver, callback);
}

void Emit::RadioMessage(const std::string& message) {
    mCallback->call([message](Napi::Env env, std::vector<napi_value>& args) {
        args = { _s("message"), _s(message) };
    });
}
