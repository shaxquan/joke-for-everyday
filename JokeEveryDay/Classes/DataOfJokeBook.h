//
//  DataOfJokeBook.h
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataOfJokeBook : NSObject

- (NSMutableArray *)jokeList:(NSData *)siteData;
- (NSMutableArray *)jokeContext:(NSData *)contextData;

// get total page of jokes
- (NSInteger)theCountOfPages:(NSURL *)url;
@end
