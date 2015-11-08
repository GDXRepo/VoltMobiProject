//
//  VMPUpdateTimeView.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPUpdateTimeView.h"
#import "VMPFormatter.h"
#import "VMPPainter.h"


@interface VMPUpdateTimeView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation VMPUpdateTimeView


#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.timeLabel.textColor = [VMPPainter instance].textUtility;
}


#pragma mark - Common

- (void)update {
    NSDate *date = [NSDate date];
    
    self.timeLabel.text = [[NSString stringWithFormat:NSLocalizedString(@"main.updateTime", nil),
                            [[VMPFormatter instance].timeOnlyDateFormatter stringFromDate:date]]
                           uppercaseString];
}

@end
