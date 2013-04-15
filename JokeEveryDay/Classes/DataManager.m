//
//  DataManager.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "DataManager.h"
#import "DataOfJokeBook.h"
static DataManager *instance = nil;

@implementation DataManager
@synthesize jokeData;
@synthesize list;
@synthesize strContent;
+ (DataManager *)sharedDataManager {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[DataManager alloc] init];
        }
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.jokeData = [NSMutableData data];
    }
    
    return self;
}

- (void)loadJokeListWithDelegate:(JokeListViewController *)viewController AndUrlStr:(NSString *)urlStr {
    isLoadList = YES;
    [self startUrlConnectionWithDelegate:viewController andUrlStr:urlStr];
}

- (void)loadJokeContentWithDelegate:(JokeDetailViewController *)viewController andUrlStr:(NSString *)urlStr {
    isLoadList = NO;
    [self startUrlConnectionWithDelegate:viewController andUrlStr:urlStr];
}

- (void)startUrlConnectionWithDelegate:(id)viewController andUrlStr:(NSString *)urlStr {
    delegate = viewController;
    [self.jokeData setLength:0];
    
    
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSLog(@"%@", encodedString);
    NSURL *url = [NSURL URLWithString:encodedString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode != 200) {
        NSLog(@"response error");
        [connection cancel];

        return;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"receive Data");
    [jokeData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection Error");
    [connection cancel];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (jokeData != nil && [jokeData length] != 0) {
        DataOfJokeBook *jokeBook = [[DataOfJokeBook alloc] init];
        if (isLoadList) {

            self.list = [jokeBook jokeList:jokeData];
            if ([delegate respondsToSelector:@selector(reloadListTable)]) {
                [delegate performSelector:@selector(reloadListTable)];
            }
            isLoadList = NO;
        }
        else{
            self.strContent = [jokeBook jokeContext:jokeData];
            if ([delegate respondsToSelector:@selector(reloadTextView)]) {
                [delegate performSelector:@selector(reloadTextView)];
            }
        }
    }
}

@end
