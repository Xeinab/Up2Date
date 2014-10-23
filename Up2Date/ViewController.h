//
//  ViewController.h
//  Up2Date
//
//  Created by Zee on 10/21/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIView *newsTitleView;
    BOOL isDoneRefreshingData;
}

@property(nonatomic,retain) IBOutlet UIView *newsTitleView;

@end

