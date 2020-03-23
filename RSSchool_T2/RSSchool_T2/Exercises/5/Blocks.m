#import "Blocks.h"

@implementation Blocks

Class _class;
NSArray *_array;

- (instancetype) init{
    self = [super init];
    if(self){
        self.blockA = ^(NSArray* array){
            _array = array;
        };
        self.blockB = ^(Class class){
            _class = class;
            NSMutableArray *elementsToProcess = [NSMutableArray new];
            for(id val in _array){
                if([val isKindOfClass:_class]){
                    [elementsToProcess addObject:val];
                }
            }
            if(_class == [NSString class]){
                NSMutableString *sResult = [NSMutableString new];
                for (NSString *s in elementsToProcess) {
                    [sResult appendString:s];
                }
                self.blockC(sResult);
            } else if(_class == [NSNumber class]){
                int result = 0;
                for (NSNumber *n in elementsToProcess) {
                    result += n.intValue;
                }
                self.blockC([NSNumber numberWithInt:result]);
            } else if(_class == [NSDate class]){
                [elementsToProcess sortUsingSelector:@selector(compare:)];
                NSDateFormatter *formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"dd.MM.yyyy"];
                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                self.blockC( [formatter stringFromDate:elementsToProcess.lastObject]);
            }
        };
    }
    return self;
}

@end

