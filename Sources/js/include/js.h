#import <Foundation/Foundation.h>

typedef void (^cb)(BOOL status);

@interface JS : NSObject
- (instancetype) init : (NSString*) test;
- (void) run : (cb)callback;
- (instancetype) hello;
@end
