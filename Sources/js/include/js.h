#import <Foundation/Foundation.h>

typedef
void (^cb) (BOOL status);

@interface JS : NSObject

- (nonnull instancetype) init : (NSString* _Nonnull) code;
- (void) run: (cb _Nullable ) callback;

@end
