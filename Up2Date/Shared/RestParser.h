//
//  RestParser.h
//  Up2Date
//
//  Created by Zee on 10/22/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestParser : NSObject


+(NSMutableArray*)parseNewsData :(NSDictionary*)jsonAllData;

@end
