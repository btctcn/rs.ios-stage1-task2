#import <Foundation/Foundation.h>
#import "NSString+Transform.h"

@implementation NSString (Transform)

-(NSString*)transform {
    NSSet *vowelsSet = [NSSet setWithArray: @[ @"a", @"e", @"i", @"o", @"u", @"y"]];
    NSSet *consonantsSet = [NSSet setWithArray:@[@"q",@"w",@"r",@"t",@"p",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"]];
    NSMutableSet *allSet = [NSMutableSet new];
    NSMutableSet *selfSet = [NSMutableSet new];
    [allSet unionSet:vowelsSet];
    [allSet unionSet:consonantsSet];
    NSUInteger selfLen = [self length];

    for (int i = 0; i < selfLen; i++){
        [selfSet addObject:[[self substringWithRange:NSMakeRange(i, 1)] lowercaseString]];
    }
    
    NSMutableSet *allSetCopy = [allSet mutableCopy];
    [allSetCopy minusSet:selfSet];
    
    BOOL isPangram = allSetCopy.count == 0;
    NSMutableArray *tokens = [[self componentsSeparatedByString:@" "] mutableCopy];
    NSUInteger tokensLen = tokens.count;
    for(int i = 0; i < tokensLen; i++){
        NSString *currentToken = tokens[i];
        NSMutableSet *toBeCapitalizedSet = [((isPangram) ? vowelsSet : consonantsSet) mutableCopy];
        NSEnumerator *enumerator = [toBeCapitalizedSet objectEnumerator];
        NSString *currentChar;
        while((currentChar = [enumerator nextObject])) {
            currentToken = [currentToken stringByReplacingOccurrencesOfString:currentChar withString:[currentChar capitalizedString]];
        }
        
        int counter = 0;
        for(int j = 0; j < currentToken.length; j++) {
            currentChar = [[currentToken substringWithRange:NSMakeRange(j, 1)] lowercaseString];
            if([toBeCapitalizedSet containsObject:currentChar]) counter++;
        }
        
        currentToken = [currentToken mutableCopy];
        currentToken = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithUnsignedLong:counter], currentToken];
        tokens[i] = currentToken;
    }
    
    NSArray * sortedTokens = [tokens sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        
        int index1 = [[str1 substringWithRange:NSMakeRange(0,1)] intValue];
        int index2 = [[str2 substringWithRange:NSMakeRange(0,1)] intValue];
        
        if(index1 < index2) return NSOrderedAscending;
        if(index1 > index2) return NSOrderedDescending;
        
        return NSOrderedSame;
    }];
    
    NSString *result = @"";
    for(int i = 0; i < sortedTokens.count; i++){
        if([sortedTokens[i] isEqualToString:@"0"]) continue;
        result = [NSString stringWithFormat:@"%@%@%@", result, ((result.length > 0) ? @" " : @""), sortedTokens[i]];
    }
    
    return result;
}

@end
