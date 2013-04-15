//
//  AppDelegate.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "AppDelegate.h"
#import "JokeListViewController.h"
#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "SettingViewController.h"
#import "GADBannerView.h"
#import "GADRequest.h"

#define kAdUnitID @"a151399143d9f48"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_centerController release];
    [_leftController release];
    [_settingController release];
    [super dealloc];
}

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    JokeListViewController *jokeListViewController = [[[JokeListViewController alloc] initWithNibName:@"JokeListViewController" bundle:nil] autorelease];
    self.centerController = [[UINavigationController alloc] initWithRootViewController:jokeListViewController];

    self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    
    IIViewDeckController *deckController = [[[IIViewDeckController alloc] initWithCenterViewController:self.centerController leftViewController:self.leftController] autorelease];
    
    SettingViewController *sViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    self.settingController = [[UINavigationController alloc] initWithRootViewController:sViewController];
    [sViewController release];
    
    CGPoint origin = CGPointMake(0.0,
                                 self.centerController.view.frame.size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeBanner).height - 20);
    self.adBanner = [[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner
                                                    origin:origin]
                     autorelease];
    
    self.adBanner.adUnitID = kAdUnitID;
    self.adBanner.delegate = self;
    [self.adBanner setRootViewController:self.centerController];
    [self.centerController.view addSubview:self.adBanner];
    self.adBanner.center = CGPointMake(self.centerController.view.center.x, self.adBanner.center.y);
    [self.adBanner loadRequest:[self createRequest]];

    self.window.rootViewController = deckController;

//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad.
//    request.testing = YES;
//    request.testDevices = [NSArray arrayWithObjects:
//                           @"YOUR_SIMULATOR_IDENTIFIER",
//                           @"YOUR_DEVICE_IDENTIFIER",
//                           nil];
    
    return request;
}

// We've received an ad successfully.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
