//
//  VMPNet.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPNet.h"
#import "VMPCurrencyPair.h"
#import "VMPFormatter.h"


@interface VMPNet () {
    dispatch_queue_t queueMain;
    dispatch_queue_t queueRequest;
}

@end


@implementation VMPNet


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, @"Use 'instance' instead.");
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        queueMain = dispatch_get_main_queue();
        queueRequest = dispatch_queue_create("VMPNet.request", 0);
    }
    return self;
}

+ (instancetype)instance {
    static VMPNet *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] initPrivate];
    });
    return instance;
}


#pragma mark - Requests

- (void)requestRatesForCurrencyPair:(VMPCurrencyPair *)pair {
    // http://api.fixer.io/latest?base=USD&symbols=RUR&date=2015-11-05
    NSAssert(pair.currencyFrom && pair.currencyTo, @"Invalid input pair.");
    
    NSDate *dateToday = [NSDate date];
    NSDateComponents *comps = [NSDateComponents new];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [comps setDay:-1];
    NSDate *dateYesterday = [calendar dateByAddingComponents:comps toDate:dateToday options:0];
    
    NSString *const format = @"https://api.fixer.io/latest?base=%@&symbols=%@&date=%@";
    NSString *addrYesterday = [NSString stringWithFormat:format,
                               pair.currencyTo,
                               pair.currencyFrom,
                               [[VMPFormatter instance].dateOnlyDateFormatter stringFromDate:dateYesterday]];
    NSString *addrToday = [NSString stringWithFormat:format,
                           pair.currencyTo,
                           pair.currencyFrom,
                           [[VMPFormatter instance].dateOnlyDateFormatter stringFromDate:dateToday]];
    // async request
    __weak typeof(self) welf = self;
    dispatch_async(queueRequest, ^{
        __strong typeof(self) strongSelf = welf;
        
        NSData *dataYesterday = [NSData dataWithContentsOfURL:[NSURL URLWithString:addrYesterday]];
        NSData *dataToday = [NSData dataWithContentsOfURL:[NSURL URLWithString:addrToday]];
        
        NSDictionary *jsonYesterday = [NSJSONSerialization JSONObjectWithData:dataYesterday
                                                                      options:0
                                                                        error:nil];
        NSDictionary *jsonToday = [NSJSONSerialization JSONObjectWithData:dataToday
                                                                  options:0
                                                                    error:nil];
        NSNumber *rateYesterday = jsonYesterday[@"rates"][pair.currencyFrom];
        NSNumber *rateToday = jsonToday[@"rates"][pair.currencyFrom];
        
        dispatch_sync(queueMain, ^{
            [strongSelf notify:kNotificationVMPNetDidReceiveRates
                      userInfo:@{kNotificationKeyVMPNetRateYesterday : rateYesterday,
                                 kNotificationKeyVMPNetRateToday : rateToday}];
        });
    });
}

@end
