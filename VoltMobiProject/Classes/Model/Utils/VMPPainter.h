//
//  VMPPainter.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VMPPainter : NSObject {
    
}

@property (readonly, nonatomic) UIColor *textDefault;
@property (readonly, nonatomic) UIColor *textSubtitle;
@property (readonly, nonatomic) UIColor *textUtility;
@property (readonly, nonatomic) UIColor *valuePositive;
@property (readonly, nonatomic) UIColor *valueNegative;
@property (readonly, nonatomic) UIColor *selectorRow;
@property (readonly, nonatomic) UIColor *selectorRowTextDefault;
@property (readonly, nonatomic) UIColor *selectorRowTextSelected;


#pragma mark - Root

+ (instancetype)instance;

@end
