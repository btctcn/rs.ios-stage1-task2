#import "FibonacciResolver.h"

@implementation FibonacciResolver
- (NSArray*)productFibonacciSequenceFor:(NSNumber*)number {
    int num = number.intValue;
    
    int mul = 0;
    int cnt = 2;
    
    int first = 0;
    int second = 1;
    while((mul = first * second) < num){
        int next = first + second;
        first = second;
        second = next;
    }

    return @[[NSNumber numberWithInt:first], [NSNumber numberWithInt:second], (first*second == num) ? @1 : @0 ];
    
}
@end
