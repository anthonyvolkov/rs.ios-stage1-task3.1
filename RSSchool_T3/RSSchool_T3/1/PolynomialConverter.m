#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    
    if (numbers.count == 0) {
        return nil;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (numbers.count == 1) {
        if (numbers.firstObject.intValue == 0) {
            [result release];
            return nil;
        }
        [result appendFormat:@"%@", numbers.firstObject];
        return [result autorelease];
    }
    
    int pow = (int)numbers.count - 1;
    
    for (int q = 0; q < numbers.count; q++) {
        if (numbers[q].intValue == 0) {
            
            pow--;
            continue;
            
        } else if (q == (int)numbers.count - 2) {
            if (q == 0) {
                if (numbers[q].intValue < 0) {
                    abs(numbers[q].intValue) == -1   ? [result appendString:@"-x"]
                                                    : [result appendFormat:@"-%@x", numbers[q]];
                } else {
                    abs(numbers[q].intValue) == 1   ? [result appendString:@"x"]
                                                    : [result appendFormat:@"%@x", numbers[q]];
                }
            } else if (numbers[q].intValue < 0) {
                numbers[q].intValue == -1   ? [result appendString:@" - x"]
                                            : [result appendFormat:@" - %dx", abs(numbers[q].intValue)];
            } else {
                numbers[q].intValue == 1    ? [result appendString:@" + x"]
                                            : [result appendFormat:@" + %@x", numbers[q]];
            }

        } else if (q == (int)numbers.count - 1) {
            
            if (q == 0) {
                [result appendFormat:@"%@", numbers[q]];
            } else if (numbers[q].intValue < 0) {
                [result appendFormat:@" - %d", abs(numbers[q].intValue)];
            } else {
                [result appendFormat:@" + %@", numbers[q]];
            }

        } else {
            
            if (q == 0) {
                if (numbers[q].intValue < 0) {
                    numbers[q].intValue == -1   ? [result appendFormat:@"-x^%d", pow]
                                                : [result appendFormat:@"-%@x^%d", numbers[q], pow];
                } else {
                    numbers[q].intValue == 1    ? [result appendFormat:@"x^%d", pow]
                                                : [result appendFormat:@"%@x^%d", numbers[q], pow];
                }
            } else if (numbers[q].intValue < 0) {
                numbers[q].intValue == -1   ? [result appendFormat:@" - x^%d", pow]
                                            : [result appendFormat:@" - %dx^%d", abs(numbers[q].intValue), pow];
            } else {
                numbers[q].intValue == 1    ? [result appendFormat:@" + x^%d", pow]
                                            : [result appendFormat:@" + %@x^%d", numbers[q], pow];
            }
        }
        
        pow--;
    }
    
    return [result autorelease];
}
@end
