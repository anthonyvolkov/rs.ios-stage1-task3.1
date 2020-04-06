#import "Combinator.h"

@interface Combinator ()
+ (double)factorial:(int)n;
+ (int)binomialCoefficientOfValue:(int)n choose:(int)k;
@end;

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    NSNumber *result = nil;
    
    if ([array.firstObject intValue] == [array.lastObject intValue]) {
        return @1;
    }
    
    int c = 0;
    int n = [array.lastObject intValue];
    
    for (int k = 2; k <= [array.lastObject intValue]; k++) {
        
        c = [Combinator binomialCoefficientOfValue:n choose:k];  // n k
        
        if (c >= [array.firstObject intValue]) {
            result = [NSNumber numberWithInt:k];
            break;
        }
    }

    return result;
}

+ (int)binomialCoefficientOfValue:(int)n choose:(int)k {    // Ckn = n! / (n − k)! * k!
    
    double numerator = 1;
    double denominator = 1;
    
    int nk = n - k;
    int diff = n - nk;
    
    if (nk < k) {
        diff = n - k;
        
        denominator = [Combinator factorial:nk];
    } else {
        denominator = [Combinator factorial:k];
    }
    
    for (int q = 0; q < diff; q++) {
        numerator = numerator * n;
        n--;
    }
    
    return numerator/denominator;
}

+ (double)factorial:(int)n {
    if (n == 0)
        return 1;
    return n * [Combinator factorial:n - 1];
}

@end
