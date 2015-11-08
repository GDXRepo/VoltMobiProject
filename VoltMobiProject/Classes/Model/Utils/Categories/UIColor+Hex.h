//
//  UIColor+Hex.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end
