#include <iostream>

#include "libplatform/libplatform.h"
#include "v8.h"

#import "include/js.h"

using namespace std;

@implementation JS
+ (void) hello : (NSString *) name {
    cout << "Hello " << [ name cStringUsingEncoding:NSUTF8StringEncoding ] << " in Objective-C++\n";
}
@end