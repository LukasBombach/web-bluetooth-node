#pragma once

#include <napi.h>

class ThreadSafeCallback;

class Emit {
public:
    void Wrap(const Napi::Value& receiver, const Napi::Function& callback);
    void RadioMessage(const std::string& message);
protected:
    std::shared_ptr<ThreadSafeCallback> mCallback;
};
