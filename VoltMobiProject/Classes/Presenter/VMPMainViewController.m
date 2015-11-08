//
//  VMPMainViewController.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 08.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPMainViewController.h"
#import "VMPPairDashboardView.h"
#import "VMPUpdateTimeView.h"
#import "VMPSelectorView.h"
#import "MBProgressHUD.h"
#import "VMPStorage.h"
#import "VMPNet.h"
#import "VMPFormatter.h"
#import "NSObject+GDXObserver.h"


@interface VMPMainViewController ()<VMPSelectorViewDataSource, VMPSelectorViewDelegate> {
    // model
    VMPStorage *storage;
    // views
    VMPPairDashboardView *pairDashboardView;
    VMPUpdateTimeView    *updateTimeView;
    VMPSelectorView      *selectorView;
    // utils
    MBProgressHUD *hud;
    BOOL isSelectorViewDisplayed;
}

@property (weak, nonatomic) IBOutlet UIView *pairDashboardContainerView;
@property (weak, nonatomic) IBOutlet UIView *updateTimeContainerView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;


#pragma mark - UI

- (void)loadViews;
- (void)loadPairAtIndex:(NSUInteger)index;


#pragma mark - Observing

- (void)observeVMPNetDidReceiveRates:(NSNotification *)notification;


#pragma mark - Actions

- (IBAction)menuButtonClick:(id)sender;

@end


@implementation VMPMainViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // subscriptions
    [self subscribe:kNotificationVMPNetDidReceiveRates selector:@selector(observeVMPNetDidReceiveRates:)];
    // storage
    storage = [VMPStorage new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadPairAtIndex:0];
}

- (void)dealloc {
    [self unsubscribeAll];
}


#pragma mark - UI

- (void)loadViews {
    NSBundle *bundle = [NSBundle mainBundle];
    
    if (!pairDashboardView) {
        pairDashboardView = [bundle loadNibNamed:@"VMPPairDashboardView" owner:self options:nil][0];
        pairDashboardView.frame = self.pairDashboardContainerView.bounds;
        
        [self.pairDashboardContainerView addSubview:pairDashboardView];
    }
    if (!updateTimeView) {
        updateTimeView = [bundle loadNibNamed:@"VMPUpdateTimeView" owner:self options:nil][0];
        updateTimeView.frame = self.updateTimeContainerView.bounds;
        
        [self.updateTimeContainerView addSubview:updateTimeView];
    }
    if (!selectorView) {
        selectorView = [bundle loadNibNamed:@"VMPSelectorView" owner:self options:nil][0];
        CGRect rect = self.view.bounds;
        rect.origin.y = rect.size.height;
        rect.size.height = [self numberOfRowsInSelectorView:selectorView] * 44;
        selectorView.frame = rect;
        
        selectorView.dataSource = self;
        selectorView.delegate = self;
        
        [self.view addSubview:selectorView];
    }
}

- (void)loadPairAtIndex:(NSUInteger)index {
    // display HUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    hud.labelText = NSLocalizedString(@"main.updating", nil);
    hud.mode = MBProgressHUDModeIndeterminate;
    // request
    [storage activatePairAtIndex:index];
}


#pragma mark - VMPSelectorViewDataSource

- (NSUInteger)numberOfRowsInSelectorView:(VMPSelectorView *)view {
    return storage.pairs.count;
}

- (NSString *)selectorView:(VMPSelectorView *)view valueForRowAtIndex:(NSUInteger)index {
    VMPCurrencyPair *pair = storage.pairs[index];
    
    return [NSString stringWithFormat:@"%@ %@ %@",
            pair.currencyFrom,
            [VMPFormatter instance].utfArrowRight,
            pair.currencyTo];
}

- (BOOL)selectorView:(VMPSelectorView *)view shouldSelectRowAtIndex:(NSUInteger)index {
    return (index == storage.activePairIndex);
}


#pragma mark - VMPSelectorViewDelegate

- (void)selectorView:(VMPSelectorView *)view didSelectRowAtIndex:(NSUInteger)index {
    [self menuButtonClick:nil];
    
    [self loadPairAtIndex:index];
    [selectorView update];
}


#pragma mark - Observing

- (void)observeVMPNetDidReceiveRates:(NSNotification *)notification {
    [self loadViews];
    
    CGFloat valueFrom = [notification.userInfo[kNotificationKeyVMPNetRateYesterday] doubleValue];
    CGFloat valueTo = [notification.userInfo[kNotificationKeyVMPNetRateToday] doubleValue];
    // update pair dashboard
    VMPCurrencyPair *pair = storage.pairs[storage.activePairIndex];
    pairDashboardView.pairCurrencyFrom = pair.currencyFrom;
    pairDashboardView.pairCurrencyTo = pair.currencyTo;
    pairDashboardView.valueOld = valueFrom;
    pairDashboardView.valueNew = valueTo;
    [pairDashboardView update];
    // update time
    [updateTimeView update];
    // update rows
    [selectorView update];
    // hide HUD
    [hud hide:YES];
}


#pragma mark - Actions

- (IBAction)menuButtonClick:(id)sender {
    CGRect rect = selectorView.frame;
    CGRect rectDashboard = self.pairDashboardContainerView.frame;
    
    if (isSelectorViewDisplayed) {
        rect.origin.y += rect.size.height;
        rectDashboard.origin.y = 100;
    }
    else {
        rect.origin.y -= rect.size.height;
        
        if (CGRectIntersectsRect(rectDashboard, rect)) {
            rectDashboard.origin.y -= 70;
        }
    }
    isSelectorViewDisplayed = !isSelectorViewDisplayed;
    
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         selectorView.frame = rect;
                         welf.pairDashboardContainerView.frame = rectDashboard;
                     }
                     completion:nil];
}

@end
