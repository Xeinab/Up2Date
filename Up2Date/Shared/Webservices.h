//
//  Webservices.h
//  Up2Date
//
//  Created by Zee on 10/21/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMHTTPFetcher.h"

@interface Webservices : NSObject
{
    NSString *url;
    
    id webservicesDelegate;
    SEL webservicesSelector;
}

-(void)downloadNewsData :(id)delegate :(SEL)finishedSelector;
-(void)downloadNewsDataHandler :(GTMHTTPFetcher*)fetcher finishedWithData :(NSData *)retrievedData error :(NSError *)error;
@end
