#pragma once

#import <Cocoa/Cocoa.h>
#include <napi.h>
#include "napi_objc.h"
    
/* @interface Photo : NSObject {
    NSString* caption;
    NSString* photographer;
}

- (NSString*) caption;
- (NSString*) photographer;

- (void) setCaption: (NSString*)input;
- (void) setPhotographer: (NSString*)input;

@end     */    


class Photo : public Napi::ObjectWrap<Photo>
{
public:
    Photo(const Napi::CallbackInfo&);
    Napi::Value setCaption(const Napi::CallbackInfo&);
    Napi::Value setPhotographer(const Napi::CallbackInfo&);
    // Napi::String getCaption(const Napi::CallbackInfo&);
    // Napi::String getPhotographer(const Napi::CallbackInfo&);
    std::string getCaption(const Napi::CallbackInfo&);
    std::string getPhotographer(const Napi::CallbackInfo&);

    static Napi::Function GetClass(Napi::Env);

private:
    NSString* caption;
    NSString* photographer;
};
