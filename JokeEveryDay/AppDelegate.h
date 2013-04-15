//
//  AppDelegate.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerViewDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GADBannerViewDelegate> {
    GADBannerView *adBanner_;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) GADBannerView *adBanner;

@property (strong, nonatomic) UIViewController *centerController;
@property (strong, nonatomic) UIViewController *leftController;
@property (strong, nonatomic) UIViewController *settingController;

+ (AppDelegate *)sharedAppDelegate;
@end
