//
//  JokeDetailViewController.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeDetailViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextView *textView;

- (void)reloadDataWithURLStr:(NSString *)urlStr;
@end
