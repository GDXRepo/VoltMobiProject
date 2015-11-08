//
//  VMPCalculator.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPCalculator.h"


@implementation VMPCalculator


#pragma mark - Common

+ (NSInteger)differencePercentWithPairOldValue:(CGFloat)oldValue new:(CGFloat)newValue {
    return ceil(fabs(newValue * 100 / oldValue - 100)); // round up
}

@end
