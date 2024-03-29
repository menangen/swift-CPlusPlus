#include <iostream>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "libplatform/libplatform.h"
#include "v8.h"

#import "include/v8_scopes.cpp"
#import "include/js.h"

using v8Args = const FunctionCallbackInfo<Value>&;

@implementation JS

NSString*
sourceCode;

cb
swiftPlayer = nil;

- (nonnull instancetype) init : (NSString*) code {
    NSLog(@"Init");
    sourceCode = code;
    
    return self;
}

void Move(v8Args args) {
    NSLog(@"Move");
    
    if (swiftPlayer) {
        swiftPlayer(YES);
    } else {
        NSLog(@"Player: No callback!");
    }
}

- (void) run: (cb _Nullable) callback {
    using namespace std;
    using namespace v8;
    using namespace v8::platform;
    
    cout << "Hello in Objective-C++\n";
    
    if (callback) {
        NSLog(@"set callback");
        swiftPlayer = callback;
    }
    
    const uint8_t*
    swiftJSString = (uint8_t *) [ sourceCode cStringUsingEncoding:NSUTF8StringEncoding ];
    
    unique_ptr<Platform>
    platform = NewDefaultPlatform();
    
    V8::InitializePlatform(platform.get());
    V8::Initialize();
    
    Isolate::CreateParams
    create_params;
    create_params.array_buffer_allocator = ArrayBuffer::Allocator::NewDefaultAllocator();
    
    Isolate*
    isolate = Isolate::New(create_params);
    
    Isolate::Scope isolate_scope(isolate);
    
    // Create a stack-allocated handle scope.
    HandleScope handle_scope(isolate);
  
    Local<ObjectTemplate>
    global = ObjectTemplate::New(isolate);
    
    // Function: log
    global->Set(
                String::NewFromUtf8( isolate, "log"),
                FunctionTemplate::New( isolate,
                                       [](const auto& args) {
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
                                       }
                                      ));

    Local<ObjectTemplate>
    player = ObjectTemplate::New(isolate);
    player->Set(
                String::NewFromUtf8(isolate, "id"),
                Integer::New(isolate, 12));
    
    player->Set(
                String::NewFromUtf8(isolate, "move"),
                FunctionTemplate::New( isolate, Move ));
    
    // Object: Player
    global->Set(String::NewFromUtf8(isolate, "Player"),
                player);
    
    // Create a new context.
    Local<Context>
    context = Context::New(isolate, NULL, global);
    
    
    // Enter the context for compiling and running the hello world script.
    Context::Scope context_scope(context);
    
    // Create a string containing the JavaScript source code.
    Local<String>
    source = String::NewFromOneByte(
                                    isolate,
                                    swiftJSString,
                                    NewStringType::kNormal).ToLocalChecked();
    
    // Compile the source code.
    Local<Script>
    script = Script::Compile(context, source).ToLocalChecked();
    
    // Run the script to get the result.
    Local<Value>
    result = script -> Run(context).ToLocalChecked();
    
    String::Utf8Value utf8(isolate, result);
    printf("v8: %s\n", *utf8);
    
    
    V8::Dispose();
    V8::ShutdownPlatform();
    delete create_params.array_buffer_allocator;
}

- (void) dealloc
{
    NSLog(@"dealloc");
}
@end
