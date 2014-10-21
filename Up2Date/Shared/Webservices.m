//
//  Webservices.m
//  Up2Date
//
//  Created by Zee on 10/21/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import "Webservices.h"
#import "WError.h"
#import "SBJson.h"

@implementation Webservices

-(void)downloadNewsData :(id)delegate :(SEL)finishedSelector
{
    webservicesDelegate = delegate;
    webservicesSelector = finishedSelector;
    
    url = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"WebservicesURL"];
    
    NSURL *mergedURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:mergedURL];

    GTMHTTPFetcher* dataHandler = [GTMHTTPFetcher fetcherWithRequest:request];
    [dataHandler beginFetchWithDelegate:self didFinishSelector:@selector(downloadNewsDataHandler:finishedWithData:error:)];
}

-(void)downloadNewsDataHandler :(GTMHTTPFetcher*)fetcher finishedWithData :(NSData *)retrievedData error :(NSError *)error
{
    WError* wError = nil;
    NSDictionary* callResult;
    
    if (error != nil)
    {
        int status = [error code];
        wError = [[WError alloc]init];
        wError.errorCode = [NSString stringWithFormat:@"%d",status];
        NSLog(@"downloadNewsDataHandler - Error encountered %@",wError.errorCode);
    }
    else
    {
        NSString * string = [[NSString alloc] initWithBytes:[retrievedData bytes] length:[retrievedData length] encoding:NSUTF8StringEncoding];
         NSLog(@"downloadNewsDataHandler %@",string);
        
        callResult = [string JSONValue];
    }
    [webservicesDelegate performSelector:webservicesSelector withObject:callResult withObject:wError];
}


@end
