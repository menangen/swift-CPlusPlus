#include <iostream>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "libplatform/libplatform.h"
#include "v8.h"

#import "include/js.h"

using namespace std;

using v8::Context;
using v8::EscapableHandleScope;
using v8::External;
using v8::Function;
using v8::FunctionTemplate;
using v8::Global;
using v8::HandleScope;
using v8::Isolate;
using v8::Local;
using v8::MaybeLocal;
using v8::Name;
using v8::NamedPropertyHandlerConfiguration;
using v8::NewStringType;
using v8::Object;
using v8::ObjectTemplate;
using v8::PropertyCallbackInfo;
using v8::Script;
using v8::String;
using v8::TryCatch;
using v8::Value;

@implementation Cat
+ (void) cb {
    NSLog(@"Mau");
}
@end

@implementation JS

static void LogCallback(const v8::FunctionCallbackInfo<v8::Value>& args) {
    printf("v8: log()");
    
    if (args.Length() < 1) {
        printf("\n");
        return;
    }
    
    Isolate*
    isolate = args.GetIsolate();
    
    HandleScope
    scope(isolate);
    
    Local<Value>
    arg = args[0];
    
    String::Utf8Value
    value(isolate, arg);
    
    printf(" { %s }\n", *value);
    
    [JS cb: @"new ok"];
    [Cat cb];
}

+ (void) cb : (NSString *) message {
    NSLog(@"%@", message);
};

+ (void) hello : (NSString *) name {
    cout << "Hello in Objective-C++\n";
    
    const uint8_t*
    swiftJSString = (uint8_t *) [ name cStringUsingEncoding:NSUTF8StringEncoding ];
    
    /* Initialize V8
    const char* exec_path;
    const char* icu_data_file = nullptr;
    
    v8::V8::InitializeICUDefaultLocation(exec_path, icu_data_file);
    */
    
    std::unique_ptr<v8::Platform>
    platform = v8::platform::NewDefaultPlatform();
    
    v8::V8::InitializePlatform(platform.get());
    v8::V8::Initialize();
    
    v8::Isolate::CreateParams
    create_params;
    create_params.array_buffer_allocator = v8::ArrayBuffer::Allocator::NewDefaultAllocator();
    
    v8::Isolate*
    isolate = v8::Isolate::New(create_params);
    
    v8::Isolate::Scope isolate_scope(isolate);
    
    // Create a stack-allocated handle scope.
    v8::HandleScope handle_scope(isolate);
    
    Local<ObjectTemplate> global = ObjectTemplate::New(isolate);
    global->Set(
                String::NewFromUtf8(isolate, "log", v8::NewStringType::kNormal).ToLocalChecked(),
                FunctionTemplate::New(isolate, LogCallback));
    
    // Create a new context.
    v8::Local<v8::Context>
    context = v8::Context::New(isolate, NULL, global);
    
    
    // Enter the context for compiling and running the hello world script.
    v8::Context::Scope context_scope(context);
    
    // Create a string containing the JavaScript source code.
    v8::Local<v8::String>
    source = v8::String::NewFromOneByte(
                                        isolate,
                                        swiftJSString,
                                        v8::NewStringType::kNormal).ToLocalChecked();
    
    // Compile the source code.
    v8::Local<v8::Script>
    script = v8::Script::Compile(context, source).ToLocalChecked();
    
    // Run the script to get the result.
    v8::Local<v8::Value> result = script->Run(context).ToLocalChecked();
    
    v8::String::Utf8Value utf8(isolate, result);
    printf("v8: %s\n", *utf8);
    
    
    v8::V8::Dispose();
    v8::V8::ShutdownPlatform();
    delete create_params.array_buffer_allocator;
}
@end
