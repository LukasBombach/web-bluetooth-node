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

    static Napi::Function GetClass(Napi::Env);

private:
    NSString* caption;
    NSString* photographer;
};
