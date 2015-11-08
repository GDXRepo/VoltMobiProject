//
//  VMPSelectorView.h
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VMPSelectorView;


@protocol VMPSelectorViewDataSource<NSObject>
@required
- (NSUInteger)numberOfRowsInSelectorView:(VMPSelectorView *)view;
- (NSString *)selectorView:(VMPSelectorView *)view valueForRowAtIndex:(NSUInteger)index;

@optional
- (BOOL)selectorView:(VMPSelectorView *)view shouldSelectRowAtIndex:(NSUInteger)index;

@end


@protocol VMPSelectorViewDelegate<NSObject>
@required
- (void)selectorView:(VMPSelectorView *)view didSelectRowAtIndex:(NSUInteger)index;

@end


@interface VMPSelectorView : UIView {
    
}

@property (weak, nonatomic) id<VMPSelectorViewDataSource> dataSource;
@property (weak, nonatomic) id<VMPSelectorViewDelegate>   delegate;


#pragma mark - Update

- (void)update;

@end
