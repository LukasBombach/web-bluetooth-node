#pragma once

#import <Foundation/Foundation.h>
#include <napi.h>


NSString* getNSString(Napi::String string);
// Napi::String getNapiString(Napi::Env env, NSString* string) {
