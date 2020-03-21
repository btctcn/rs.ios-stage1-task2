#import <Foundation/Foundation.h>
#import "TimeConverter.h"

@implementation TimeConverter
// Complete the following function
- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    int hoursInt = [hours intValue];
    int minutesInt = [minutes intValue];
    
    if(hoursInt < 0 || hoursInt > 23 || minutesInt < 0 || minutesInt > 59) return @"";
    
    NSString *quarter = @"quarter";
    NSString *oclock = @"o' clock";
    NSString *half = @"half";
    
    if(minutesInt == 0) {
        return[NSString stringWithFormat:@"%@ o' clock", [self converToWords:hoursInt]];
    }
    
    if(minutesInt == 15) {
        return [NSString stringWithFormat:@"quarter past %@", [self converToWords:hoursInt]];
    }
    
    if(minutesInt == 30) {
        return [NSString stringWithFormat:@"half past %@", [self converToWords:hoursInt]];
    }
    
    if(minutesInt == 45) {
        return [NSString stringWithFormat:@"quarter to %@", [self converToWords:(hoursInt + 1) % 24]];
    }
    
    minutes = [self converToWords: ((minutesInt < 30) ? minutesInt : (60 - minutesInt))];
    hours = [self converToWords:hoursInt + ((minutesInt < 30) ? 0 : 1) % 24];
    return [NSString stringWithFormat:@"%@ minutes %@ %@", minutes, (minutesInt < 30) ? @"past" : @"to", hours];
}

- (NSString *) converToWords:(int)value {
    short tens = value  / 10;
    short ones = (tens) ? value % (tens * 10) : value;
    NSDictionary *onesDict = @{
        @0 : @"zero",
        @1 : @"one",
        @2 : @"two",
        @3 : @"three",
        @4 : @"four",
        @5 : @"five",
        @6 : @"six",
        @7 : @"seven",
        @8 : @"eight",
        @9 : @"nine"};
    
    NSDictionary *tenDict = @{
        @1 : @"ten",
        @2 : @"twenty",
        @3 : @"thirty",
        @4 : @"fourty",
        @5 : @"fifty",
        @6 : @"sixty"};
    
    NSDictionary *teenDict = @{
        @11: @"eleven",
        @12: @"twelve",
        @13: @"thirteen",
        @14: @"fourteen",
        @15: @"fifteen",
        @16: @"sixteen",
        @17: @"seventeen",
        @18: @"eighteen",
        @19: @"nineteen"};
    
    if(tens >= 2)
    {
        return [NSString stringWithFormat:@"%@ %@", tenDict[[NSNumber numberWithInt:tens]], onesDict[[NSNumber numberWithInt:ones]]];
    }
    
    if(tens == 1)
    {
        return [NSString stringWithFormat:@"%@", teenDict[[NSNumber numberWithInt:10 + ones]]];
    }
    
    return [NSString stringWithFormat:@"%@", onesDict[[NSNumber numberWithInt:ones]]];
}

@end
