//
//  VMPCurrencyPair.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPCurrencyPair.h"


@implementation VMPCurrencyPair


#pragma mark - Root

+ (instancetype)pairFrom:(NSString *)from to:(NSString *)to {
    VMPCurrencyPair *pair = [self.class new];
    pair.currencyFrom = from;
    pair.currencyTo = to;
    
    return pair;
}

@end
