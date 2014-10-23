//
//  ViewController.m
//  Up2Date
//
//  Created by Zee on 10/21/14.
//  Copyright (c) 2014 apps2you. All rights reserved.
//

#import "ViewController.h"
#import "Webservices.h"
#import "WError.h"
#import "RestParser.h"
#import "MiscFunctionalities.h"

#define TEXT_FONT [UIFont systemFontOfSize:14]

@implementation ViewController
@synthesize newsTitleView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadData];
}


-(void)downloadData
{
    isDoneRefreshingData = NO;
    Webservices* services = [[Webservices alloc]init];
    [services downloadNewsData:self :@selector(downloadNewsDataDone::)];
}

-(void)downloadNewsDataDone:(NSArray *)callResult :(WError *)error
{
    if (error == nil)
    {
        NSMutableArray *newsList  = [RestParser parseNewsData :callResult];
        if ([newsList count]>0)
        {
            NSString *news = [newsList componentsJoinedByString:@"   *   "];
            [self showNews :news];
        }
        else
        {
            [self showNews :NSLocalizedString(@"U2D_NO_DATA_EXITS", @"")];
        }
    }
    else
    {
        [self showNews :NSLocalizedString(@"U2D_ERROR_OCCURRED", @"")];
    }
    isDoneRefreshingData = YES;
}

-(void)showNews :(NSString*)news
{
    BOOL isArabicSupported = [MiscFunctionalities isArabicSupported];

    CGSize expectedLabelSize = [news sizeWithAttributes:@{NSFontAttributeName:TEXT_FONT}];
    int textLength = expectedLabelSize.width + 50;
    int xPosition = self.view.frame.size.width;
    
    UILabel *newsTitleLabel = [[UILabel alloc]init];
    if (isArabicSupported)
    {
        newsTitleLabel.frame =CGRectMake( -textLength , 15, textLength, 50);
        newsTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        newsTitleLabel.frame =CGRectMake(xPosition, 15, textLength, 50);
    }

    
    [newsTitleLabel setFont:TEXT_FONT];
    [newsTitleView addSubview:newsTitleLabel];
    newsTitleLabel.text = news;
    
    float duration = textLength / 100 ;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^
     {
         if (isArabicSupported)
         {
             newsTitleLabel.frame = CGRectMake(xPosition, newsTitleLabel.frame.origin.y,textLength, newsTitleLabel.frame.size.height);
         }
         else
         {
             newsTitleLabel.frame = CGRectMake(-textLength, newsTitleLabel.frame.origin.y,textLength, newsTitleLabel.frame.size.height);
         }
         
     } completion:^(BOOL finished)
     {
         [newsTitleLabel removeFromSuperview];
         if (isDoneRefreshingData)
         {
             [self downloadData];
         }
         else
         {
            [self showNews :news];
         }
     }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
