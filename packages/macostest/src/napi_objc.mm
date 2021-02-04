#include "napi_objc.h"

NSString* napiToUuidString(Napi::String string) {
    std::string str = string.Utf8Value();
    NSMutableString * uuid = [[NSMutableString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
    if([uuid length] == 32) {
        [uuid insertString: @"-" atIndex: 8];
        [uuid insertString: @"-" atIndex: 13];
        [uuid insertString: @"-" atIndex: 18];
        [uuid insertString: @"-" atIndex: 23];
    }
    return [uuid uppercaseString];
}

NSArray* napiToUuidArray(Napi::Array array) {
    NSMutableArray* serviceUuids = [NSMutableArray arrayWithCapacity:array.Length()];
    for(size_t i = 0;  i < array.Length(); i++) {
        Napi::Value val = array[i];
        [serviceUuids addObject:napiToUuidString(val.As<Napi::String>())];
    }
    return serviceUuids;
}

NSData* napiBuffer(Napi::Buffer<Byte> buffer) {
    return [NSData dataWithBytes:buffer.Data() length:buffer.Length()];
}

NSNumber* napiNumber(Napi::Number number) {
    return [NSNumber numberWithInt:number.Int64Value()];
}

NSArray* getUuidArray(const Napi::Value& value) {
    if (value.IsArray()) {
        return napiToUuidArray(value.As<Napi::Array>());
    }
    return nil;
}

BOOL getBool(const Napi::Value& value, BOOL def) {
    if (value.IsBoolean()) {
        return value.As<Napi::Boolean>().Value();
    }
    return def;
}
