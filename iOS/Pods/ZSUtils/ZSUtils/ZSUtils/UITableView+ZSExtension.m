//
//  UITableView+ZSExtension.m
//  YuanDongLi
//
//  Created by 张帅 on 2018/5/19.
//  Copyright © 2018年 Convey Network Technology. All rights reserved.
//

#import "UITableView+ZSExtension.h"

#define m_UseFooterView 0

@implementation UITableView (ZSExtension)

- (void)reloadDataWithEmptyView:(UIView *)emptyView {
    [self reloadData];
    BOOL isEmpty = YES;
    NSInteger sectionCount = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < sectionCount; i++) {
        NSInteger rowCount = 0;
        if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            rowCount = [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount) { isEmpty = NO; break; }
    }
    if (isEmpty) {
#if m_UseFooterView
        emptyView.frame = self.bounds;
        self.tableFooterView = emptyView;
#else
        self.backgroundView = emptyView;
#endif
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
#if m_UseFooterView
        self.tableFooterView = nil;
#else
        self.backgroundView = nil;
#endif
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
