#include "napi_objc.h"

NSString* getNSString(Napi::String string) {
    std::string str = string.Utf8Value();
    return [[NSMutableString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
}
