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

+(NSMutableArray*)parseNewsData :(NSArray*)jsonAllData
{
    NSMutableArray *news = [NSMutableArray array];
    
    for (int i=0;i<[jsonAllData count];i++)
    {
        NSDictionary *feedsDictionary = [jsonAllData objectAtIndex:i];
        NSString *newsTitle =  ([feedsDictionary valueForKey:@"newsTitle"]  == (NSString *) [NSNull null] ? @"" : [feedsDictionary valueForKey:@"newsTitle"]);
        [news addObject:newsTitle];
        
    }
    return news;
}


@end
