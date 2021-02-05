#include <napi.h>
#include "napi_objc.h"
#import "Photo.h"

/* @implementation Photo

- (id) init
{
    if ( self = [super init] )
    {
        [self setCaption:@"Default Caption"];
        [self setPhotographer:@"Default Photographer"];
    }
    return self;
}
    
- (NSString*) caption {
    return caption;
}

- (NSString*) photographer {
    return photographer;
}

- (void) setCaption: (NSString*)input
{
    [caption autorelease];
    caption = [input retain];
}

- (void) setPhotographer: (NSString*)input
{
    [photographer autorelease];
    photographer = [input retain];
}

@end
 */



Photo::Photo(const Napi::CallbackInfo& info) : ObjectWrap(info) {
    caption = @"Default Caption";
    photographer = @"Default Photographer";
}

// Napi::String Photo::getCaption(const Napi::CallbackInfo& info) {
std::string Photo::getCaption(const Napi::CallbackInfo& info) {
    return std::string([caption UTF8String]).c_str();
    // return [caption UTF8String] 
    // return Napi::String::New(info.Env(), "getCaption");
    // return getNapiString(info.Env(), caption);
}

// Napi::String Photo::getPhotographer(const Napi::CallbackInfo& info) {
std::string Photo::getPhotographer(const Napi::CallbackInfo& info) {
    return std::string([photographer UTF8String]).c_str();
    // return [photographer UTF8String] 
    // return Napi::String::New(info.Env(), "getPhotographer");
    // return getNapiString(info.Env(), photographer);
}

Napi::Value Photo::setCaption(const Napi::CallbackInfo& info) {
    caption = getNSString(info[0].As<Napi::String>());
    return Napi::Value();
}

Napi::Value Photo::setPhotographer(const Napi::CallbackInfo& info) {
    photographer = getNSString(info[0].As<Napi::String>());
    return Napi::Value();
}

Napi::Function Photo::GetClass(Napi::Env env) {
    return DefineClass(env, "Photo", {
        Photo::InstanceMethod("setCaption", &Photo::setCaption),
        Photo::InstanceMethod("setPhotographer", &Photo::setPhotographer),
        InstanceAccessor<&Photo::getCaption>("caption")

        // Photo::InstanceAccessor<&Photo::getCaption, &Photo::setCaption>("caption"),
        // Photo::InstanceAccessor<&Photo::getPhotographer, &Photo::setPhotographer>("photographer"),

        // InstanceAccessor("caption", &Photo::getCaption, &Photo::setCaption),
        // InstanceAccessor("photographer", &Photo::getPhotographer, &Photo::setPhotographer)
    });
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    Napi::String name = Napi::String::New(env, "Photo");
    exports.Set(name, Photo::GetClass(env));
    return exports;
}

NODE_API_MODULE(addon, Init)
