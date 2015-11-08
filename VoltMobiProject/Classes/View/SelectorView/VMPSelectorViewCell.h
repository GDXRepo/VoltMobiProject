//
//  VMPSelectorViewCell.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VMPSelectorViewCell : UITableViewCell {
    
}

@property (copy, nonatomic)   NSString *pair;
@property (assign, nonatomic) BOOL     shouldSelect;

@end
