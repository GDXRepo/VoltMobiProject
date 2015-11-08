//
//  VMPPairDashboardView.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VMPPairDashboardView : UIView {
    
}

@property (copy, nonatomic)   NSString *pairCurrencyFrom;
@property (copy, nonatomic)   NSString *pairCurrencyTo;
@property (assign, nonatomic) CGFloat  valueOld;
@property (assign, nonatomic) CGFloat  valueNew;


#pragma mark - Common

- (void)update;

@end
