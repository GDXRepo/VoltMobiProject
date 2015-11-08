//
//  VMPCurrencyPair.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VMPCurrencyPair : NSObject {
    
}

@property (copy, nonatomic) NSString *currencyFrom;
@property (copy, nonatomic) NSString *currencyTo;


#pragma mark - Root

+ (instancetype)pairFrom:(NSString *)from to:(NSString *)to;

@end
