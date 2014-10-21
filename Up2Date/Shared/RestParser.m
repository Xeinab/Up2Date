//
//  RestParser.m
//  Up2Date
//
//  Created by Zee on 10/22/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import "RestParser.h"
#import "NewsData.h"

@implementation RestParser

+(NSMutableArray*)parseNewsData :(NSDictionary*)jsonAllData
{
    NSMutableArray *news = [NSMutableArray array];
    
    NSArray *feedsArray = ([jsonAllData valueForKey:@"feeds"]  == (NSArray *) [NSNull null] ? @"" : [jsonAllData valueForKey:@"feeds"]);
    if ([feedsArray count] > 0)
    {
        for (int i=0;i<[feedsArray count];i++)
        {
            NSDictionary *feedsDictionary = [feedsArray objectAtIndex:i];
            NSDictionary *subFeedsDictionary = [feedsDictionary valueForKey:@"feeds"];
            for (NSDictionary *feed in subFeedsDictionary)
            {
                NSString *newsTitle =  ([feed valueForKey:@"title"]  == (NSString *) [NSNull null] ? @"" : [feed valueForKey:@"title"]);
                [news addObject:newsTitle];
            }
            
        }
    }
    return news;
}


@end
