#import <Foundation/Foundation.h>
#import "Dates.h"

@implementation Dates

- (NSString *)textForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [formatter setDateFormat:@"d MMMM, EEEE"];
    
    NSDate *date = [self dateForDay:day month:month year:year];
    NSString *result = (date) ? [formatter stringFromDate:date] : @"Такого дня не существует";
    NSLog(@"%@", result);
    return result;
}

- (NSDate *) dateForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [formatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@", year, month, day]];
}

@end
