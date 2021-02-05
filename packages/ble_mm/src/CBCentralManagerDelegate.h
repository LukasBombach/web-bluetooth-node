#include <napi.h>

class CBCentralManagerDelegate : public Napi::ObjectWrap<CBCentralManagerDelegate> {
    public:
        static Napi::Object Init(Napi::Env env, Napi::Object exports);
        CBCentralManagerDelegate(const Napi::CallbackInfo& info);
        
    private:
        static Napi::FunctionReference constructor;
};