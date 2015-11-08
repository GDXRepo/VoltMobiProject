//
//  VMPNet.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GDXObserver.h"

@class VMPCurrencyPair;

// notifications
NFDECLARE(VMPNetDidReceiveRates);
NFDECLARE(VMPNetDidFail);
// notification keys
NFDECLAREKEY(VMPNetRateYesterday);
NFDECLAREKEY(VMPNetRateToday);


@interface VMPNet : NSObject {
    
}

#pragma mark - Root

+ (instancetype)instance;


#pragma mark - Requests

- (void)requestRatesForCurrencyPair:(VMPCurrencyPair *)pair;

@end
