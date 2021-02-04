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

Napi::Value Photo::setCaption(const Napi::CallbackInfo& info) {
    NSString* input = getNSString(info[0].As<Napi::String>());
    caption = input;
    return Napi::Value();
}

Napi::Value Photo::setPhotographer(const Napi::CallbackInfo& info) {
    NSString* input = getNSString(info[0].As<Napi::String>());
    photographer = input;
    return Napi::Value();
}

Napi::Function Photo::GetClass(Napi::Env env) {
    return DefineClass(env, "Photo", {
        Photo::InstanceMethod("setCaption", &Photo::setCaption),
        Photo::InstanceMethod("setPhotographer", &Photo::setPhotographer),
    });
}


Napi::Object Init(Napi::Env env, Napi::Object exports) {
    Napi::String name = Napi::String::New(env, "Photo");
    exports.Set(name, Photo::GetClass(env));
    return exports;
}

NODE_API_MODULE(addon, Init)
