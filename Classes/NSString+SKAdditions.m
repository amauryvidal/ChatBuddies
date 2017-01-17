#import "NSString+SKAdditions.h"

@implementation NSString (NSStringSKAdditions)

- (NSArray *)matchesInString:(NSString *)string pattern:(NSString*)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSAssert1(error == nil, @"Regexp error %@", error);
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSMutableArray *result = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = match.range;
        [result addObject:[string substringWithRange:matchRange]];
        NSLog(@"Found match: %@",result.lastObject);
    }
    return result;
}

@end
