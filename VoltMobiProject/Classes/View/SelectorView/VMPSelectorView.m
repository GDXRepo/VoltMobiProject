//
//  VMPSelectorView.m
//  VoltMobiProject
//
//  Created by Георгий Малюков on 09.11.15.
//  Copyright © 2015 Георгий Малюков. All rights reserved.
//

#import "VMPSelectorView.h"
#import "VMPSelectorViewCell.h"


@interface VMPSelectorView ()<UITableViewDataSource, UITableViewDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation VMPSelectorView


#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // modify separator insets
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"VMPSelectorViewCell"
                                              bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CellId"];
}


#pragma mark - Update

- (void)update {
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSelectorView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    
    VMPSelectorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.pair = [self.dataSource selectorView:self valueForRowAtIndex:indexPath.row];
    
    if ([self.dataSource respondsToSelector:@selector(selectorView:shouldSelectRowAtIndex:)]) {
        cell.shouldSelect = [self.dataSource selectorView:self shouldSelectRowAtIndex:indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate selectorView:self didSelectRowAtIndex:indexPath.row];
}

@end
