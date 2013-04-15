//
//  JokeDetailViewController.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "JokeDetailViewController.h"
#import "DataManager.h"

@interface JokeDetailViewController ()

@end

@implementation JokeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)reloadDataWithURLStr:(NSString *)urlStr {
    [[DataManager sharedDataManager] loadJokeContentWithDelegate:self andUrlStr:urlStr];
}

- (void)reloadTextView {
    NSMutableString *content = [NSMutableString string];
    for (NSString *str in [DataManager sharedDataManager].strContent) {
        [content appendString:str];
    }
    self.textView.text = content;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textView release];
    [super dealloc];
}
@end
