#import <Foundation/Foundation.h>

@interface NSString (NSStringSKAdditions)

- (NSArray *)matchesInString:(NSString *)string pattern:(NSString*)pattern;

@end
