//
//  DataManager.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <Foundation/Foundation.h>

@class JokeListViewController;
@class JokeDetailViewController;
@interface DataManager : NSObject {
    id delegate;
    NSMutableData *jokeData;
    NSArray *list;
    NSArray *strContent;
    BOOL isLoadList;
}
@property (nonatomic, retain) NSMutableData *jokeData;
@property (nonatomic, retain) NSArray *list;
@property (nonatomic, retain) NSArray *strContent;
+ (DataManager *)sharedDataManager;

- (void)loadJokeListWithDelegate:(JokeListViewController *)viewController AndUrlStr:(NSString *)urlStr;
- (void)loadJokeContentWithDelegate:(JokeDetailViewController *)viewController andUrlStr:(NSString *)urlStr;
@end
