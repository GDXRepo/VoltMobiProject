//
//  VMPFormatter.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface VMPFormatter : NSObject {
    
}
// date formatters
@property (readonly, nonatomic) NSDateFormatter *timeOnlyDateFormatter;
@property (readonly, nonatomic) NSDateFormatter *dateOnlyDateFormatter;
// UTF
@property (readonly, nonatomic) NSString *utfArrowRight;
// fonts
@property (readonly, nonatomic) UIFont *fontSelectorRowDefault;
@property (readonly, nonatomic) UIFont *fontSelectorRowSelected;


#pragma mark - Root

+ (instancetype)instance;


#pragma mark - Utils

+ (NSString *)percentageStringWithPercent:(NSInteger)value;

@end
