#import <Foundation/Foundation.h>

typedef void (^cb)(BOOL status);

@interface JS : NSObject
+ (void) run : (cb)callback;
+ (void) hello : (NSString *) name;
@end
