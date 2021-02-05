#import <Foundation/Foundation.h>
#include "napi_objc.h"

NSString* getNSString(Napi::String string) {
    std::string str = string.Utf8Value();
    return [[NSMutableString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
}

// Napi::String getNapiString(Napi::Env env, NSString* str) {
//     return Napi::String::New(env, [str UTF8String]);
//     // return Napi::String::New(env, std::string([str UTF8String]).c_str());
// 
//     /* std::string([string UTF8String]).c_str()));
// 
//     std::string str = string.Utf8Value();
// 
//     NSMutableString * uuid = [[NSMutableString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
//     if([uuid length] == 32) {
//         [uuid insertString: @"-" atIndex: 8];
//         [uuid insertString: @"-" atIndex: 13];
//         [uuid insertString: @"-" atIndex: 18];
//         [uuid insertString: @"-" atIndex: 23];
//     }
//     return [uuid uppercaseString]; */
// }