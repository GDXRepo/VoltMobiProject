//
//  VMPPairDashboardView.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPPairDashboardView.h"
#import "VMPFormatter.h"
#import "VMPCalculator.h"
#import "VMPPainter.h"


@interface VMPPairDashboardView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *pairLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *plResultLabel;


#pragma mark - Private

- (void)configurePLResult;

@end


@implementation VMPPairDashboardView


#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    VMPPainter *painter = [VMPPainter instance];
    
    self.pairLabel.textColor = painter.textSubtitle;
    self.valueLabel.textColor = painter.textDefault;
}


#pragma mark - Common

- (void)update {
    NSAssert(self.pairCurrencyFrom && self.pairCurrencyTo, @"Values must be set.");
    
    self.pairLabel.text = [NSString stringWithFormat:@"%@ %@ %@",
                           self.pairCurrencyFrom,
                           [VMPFormatter instance].utfArrowRight,
                           self.pairCurrencyTo];
    self.valueLabel.text = [NSString stringWithFormat:@"%.3f", self.valueNew];
    
    [self configurePLResult];
}


#pragma mark - Private

- (void)configurePLResult {
    BOOL ascending = (self.valueOld <= self.valueNew);
    
    NSString *format = NSLocalizedString(@"main.plResult", nil);
    NSString *currency = NSLocalizedString(self.pairCurrencyFrom, nil);
    NSString *updown = ((ascending)
                        ? NSLocalizedString(@"main.plResult.up", nil)
                        : NSLocalizedString(@"main.plResult.down", nil));
    NSInteger percent = [VMPCalculator differencePercentWithPairOldValue:self.valueOld
                                                                     new:self.valueNew];
    NSString *percentage = [VMPFormatter percentageStringWithPercent:percent];
    
    NSString *result = [NSString stringWithFormat:format, currency, updown, percent, percentage];
    // setup paragraph style
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineHeightMultiple:1.21];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    // setup attributes
    VMPPainter *painter = [VMPPainter instance];
    NSDictionary *attri = @{NSFontAttributeName :
                                [UIFont fontWithName:@"Lato-MediumItalic" size:17],
                            NSForegroundColorAttributeName :
                                (ascending) ? painter.valuePositive : painter.valueNegative,
                            NSParagraphStyleAttributeName :
                                paragraphStyle};
    // setup label
    self.plResultLabel.attributedText = [[NSAttributedString alloc] initWithString:result
                                                                        attributes:attri];
}

@end
