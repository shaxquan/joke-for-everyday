//
//  LeftViewController.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController {
    NSArray *mDataSource;
}
@property (retain, nonatomic) IBOutlet UIButton *settingButton;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
