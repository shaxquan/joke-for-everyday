//
//  JokeListViewController.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView_;
}
@property (nonatomic, retain) UITableView *tableView;
- (void)reloadDataWithURLStr:(NSString *)urlStr;
- (void)reloadListTable;
@end
