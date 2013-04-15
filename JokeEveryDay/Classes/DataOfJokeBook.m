//
//  DataOfJokeBook.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "DataOfJokeBook.h"
#import "TFHpple.h"

@implementation DataOfJokeBook
- (NSMutableArray *)jokeList:(NSData *)siteData {
//    NSString *strData = [[NSString alloc] initWithData:siteData encoding:NSUTF8StringEncoding];
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:siteData];

    NSArray *elements = [xpathParser searchWithXPathQuery:@"//html/body/center/div[2]/div[2]/div[1]/div[2]/div/div/div[1]/a"];
    NSMutableArray *jokeList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [elements count]; i ++) {
        
        TFHppleElement *element = [elements objectAtIndex:i];
        NSString *strTitle = [element objectForKey:@"title"];
        
        // NSLog(@"element is %@",strTitle);
        NSString *strUrl = [NSString  stringWithFormat:@"http://xiaohua.zol.com.cn/%@",[element objectForKey:@"href"]];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //        TFHppleElement *element = [elements objectAtIndex:i];
        //        NSString *str = [element content];
        if (strTitle) {
            //  [jockList addObject:strTitle];
            [dict setValue:strTitle forKey:@"title"];
            // NSLog(@"strTitle is %@",strTitle);
        }
        if (strUrl) {
            // [jockList addObject:strUrl];
            [dict setValue:strUrl forKey:@"href"];
            //NSLog(@"strUrl is %@",strUrl);
        }
        
        [jokeList addObject:dict];
        
    }
    [xpathParser release];
    return [jokeList autorelease];
}

- (NSMutableArray *)jokeContext:(NSData *)contextData {
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:contextData];
    NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@class='lastC']"];
    
    NSMutableArray *jokeContext = [[NSMutableArray alloc] init];
    for (int i=0; i<[elements count]; i++) {
        TFHppleElement *element = [elements objectAtIndex:i];
        NSArray *str = [element children];
        for (int i = 0 ; i < [str count]; i ++) {
            TFHppleElement *elementContext = [str objectAtIndex:i];
            NSString *strContext = [elementContext content];
            if (i == 0) {
                strContext = [strContext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            if (strContext) {
                [jokeContext addObject:strContext];
            }
        }

    }
    
    
    [xpathParser release];
    return [jokeContext autorelease];
}

- (NSInteger)theCountOfPages:(NSURL *)url {
    NSData *siteData = [[NSData alloc] initWithContentsOfURL:url];
    NSString *strData = [[NSString alloc]initWithData:siteData encoding:NSUTF8StringEncoding];
    NSLog(@"strData is %@",strData);

    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:siteData];

    NSArray *elements = [xpathParser searchWithXPathQuery:@"//html/body/center/div[2]/div[2]/div[1]/div[1]/div[6]/a"];

//	NSMutableArray *jockContext = [[NSMutableArray alloc] init];

    TFHppleElement *element = [elements objectAtIndex:0];
    NSArray *str = [element children];

    TFHppleElement *elementContext = [str objectAtIndex:0];
    NSString *strContext = [elementContext content];
    NSLog(@"strTotalPages is %@",strContext);

    return 0;
}

@end
