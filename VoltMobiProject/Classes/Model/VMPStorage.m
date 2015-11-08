//
//  VMPStorage.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPStorage.h"
#import "VMPNet.h"


@implementation VMPStorage


#pragma mark - Root

- (instancetype)init {
    self = [super init];
    if (self) {
        _pairs = @[[VMPCurrencyPair pairFrom:@"USD" to:@"RUB"],
                   [VMPCurrencyPair pairFrom:@"USD" to:@"EUR"],
                   [VMPCurrencyPair pairFrom:@"EUR" to:@"RUB"],
                   [VMPCurrencyPair pairFrom:@"EUR" to:@"USD"],
                   [VMPCurrencyPair pairFrom:@"RUB" to:@"USD"],
                   [VMPCurrencyPair pairFrom:@"RUB" to:@"EUR"]];
        _activePairIndex = NSNotFound;
    }
    return self;
}


#pragma mark - Common

- (void)activatePairAtIndex:(NSInteger)index {
    NSAssert(index >= 0 && index < self.pairs.count, @"Invalid index.");
    _activePairIndex = index;
    
    [[VMPNet instance] requestRatesForCurrencyPair:self.pairs[self.activePairIndex]];
}

@end
