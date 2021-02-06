#include <napi.h>
#import <CoreBluetooth/CoreBluetooth.h>

class CBCentralManagerDelegate : public Napi::ObjectWrap<CBCentralManagerDelegate> {
    public:
        static Napi::Object Init(Napi::Env env, Napi::Object exports);
        CBCentralManagerDelegate(const Napi::CallbackInfo& info);
        Napi::Value Scan(const Napi::CallbackInfo&);

    private:
        static Napi::FunctionReference constructor;
        CBCentralManager *centralManager;
};