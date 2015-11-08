//
//  VMPSelectorViewCell.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPSelectorViewCell.h"
#import "VMPPainter.h"
#import "VMPFormatter.h"


@interface VMPSelectorViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *pairLabel;

@end


@implementation VMPSelectorViewCell


#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [VMPPainter instance].selectorRow;
}

- (UIEdgeInsets)layoutMargins {
    return UIEdgeInsetsZero;
}


#pragma mark - Properties

- (void)setPair:(NSString *)pair {
    _pair = pair;
    
    self.shouldSelect = self.shouldSelect;
}

- (void)setShouldSelect:(BOOL)shouldSelect {
    _shouldSelect = shouldSelect;
    
    VMPFormatter *formatter = [VMPFormatter instance];
    VMPPainter *painter = [VMPPainter instance];
    
    UIFont *font = (self.shouldSelect) ? formatter.fontSelectorRowSelected : formatter.fontSelectorRowDefault;
    UIColor *color = (self.shouldSelect) ? painter.selectorRowTextSelected : painter.selectorRowTextDefault;
    
    self.pairLabel.attributedText = [[NSAttributedString alloc]
                                     initWithString:self.pair
                                     attributes:@{NSForegroundColorAttributeName : color,
                                                  NSFontAttributeName : font}];
}

@end
