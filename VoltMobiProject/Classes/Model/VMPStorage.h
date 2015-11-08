//
//  VMPStorage.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMPCurrencyPair.h"


@interface VMPStorage : NSObject {
    
}

@property (readonly, nonatomic) NSArray<VMPCurrencyPair *> *pairs;

@property (readonly, nonatomic) NSInteger activePairIndex;


#pragma mark - Common

- (void)activatePairAtIndex:(NSInteger)index;

@end
