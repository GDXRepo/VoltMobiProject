//
//  VMPFormatter.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPFormatter.h"
#import "VMPPainter.h"


@implementation VMPFormatter


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, @"Use 'instance' instead.");
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        // date formatters
        _timeOnlyDateFormatter = [NSDateFormatter new];
        [self.timeOnlyDateFormatter setDateFormat:@"HH:mm"];
        _dateOnlyDateFormatter = [NSDateFormatter new];
        [self.dateOnlyDateFormatter setDateFormat:@"YYYY-MM-dd"];
        // UTF
        _utfArrowRight = [NSString stringWithUTF8String:"\u2192"];
        // fonts
        _fontSelectorRowDefault = [UIFont fontWithName:@"Lato-Regular" size:14];
        _fontSelectorRowSelected = [UIFont fontWithName:@"Lato-Black" size:14];
    }
    return self;
}

+ (instancetype)instance {
    static VMPFormatter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] initPrivate];
    });
    return instance;
}


#pragma mark - Utils

+ (NSString *)percentageStringWithPercent:(NSInteger)value {
    value = value % 100;
    NSString *percentString = NSLocalizedString(@"utils.percent", nil);
    
    if (value >= 11 && value <= 19) {
        return percentString;
    }
    // get the last digit & check it
    NSInteger lastDigit = value % 10;
    NSString *ending = @"";
    
    switch (lastDigit) {
        case 1: {
            break;
        }
        case 2:
        case 3:
        case 4: {
            ending = NSLocalizedString(@"utils.percent.ending.several", nil);
            break;
        }
        default: {
            ending = NSLocalizedString(@"utils.percent.ending.multiple", nil);
            break;
        }
    }
    return [percentString stringByAppendingString:ending];
}

@end
