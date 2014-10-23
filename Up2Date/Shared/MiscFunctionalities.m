//
//  MiscFunctionalities.m
//  Up2Date
//
//  Created by Zee on 10/23/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import "MiscFunctionalities.h"

@implementation MiscFunctionalities

+(BOOL)isArabicSupported
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *language = [locale objectForKey: NSLocaleLanguageCode];
    
    BOOL isArabic = YES;
    if ([language hasPrefix:@"en"])
    {
        isArabic = NO;
    }
    return isArabic;
}


@end
