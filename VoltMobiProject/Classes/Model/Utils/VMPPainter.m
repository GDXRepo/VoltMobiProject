//
//  VMPPainter.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPPainter.h"
#import "UIColor+Hex.h"


@implementation VMPPainter


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, @"Use 'instance' instead.");
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _textDefault = [UIColor colorWithHexString:@"3F4753"];
        _textSubtitle = [UIColor colorWithHexString:@"3F4753" alpha:0.7];
        _textUtility = [UIColor colorWithHexString:@"3F4753" alpha:0.4];
        _valuePositive = [UIColor colorWithHexString:@"7ED321"];
        _valueNegative = [UIColor colorWithHexString:@"D0021B"];
        _selectorRow = [UIColor colorWithHexString:@"3F4753"];
        _selectorRowTextDefault = [UIColor colorWithHexString:@"FFFFFF" alpha:0.7];
        _selectorRowTextSelected = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return self;
}

+ (instancetype)instance {
    static VMPPainter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] initPrivate];
    });
    return instance;
}

@end
