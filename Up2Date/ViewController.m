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


@implementation ViewController
@synthesize newsTitleView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadData];
}


-(void)downloadData
{
    Webservices* services = [[Webservices alloc]init];
    [services downloadNewsData:self :@selector(downloadNewsDataDone::)];
}

-(void)downloadNewsDataDone:(NSDictionary *)callResult :(WError *)error
{
    if (error == nil)
    {
        NSMutableArray *newsList  = [RestParser parseNewsData :callResult];
        if ([newsList count]>0)
        {
            NSString *news = [newsList componentsJoinedByString:@"   *   "];
            [self showData :news];
        }
        else
        {
            [self showData :@"*  No data to show  *"];
        }
    }
}

-(void)showData :(NSString*)news
{
    CGSize expectedLabelSize = [news sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    int textLength = expectedLabelSize.width * 1.5;
    int screenWidth = self.view.frame.size.width;
    
    UILabel *newsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 10, 15, textLength, 50)];
    [newsTitleView addSubview:newsTitleLabel];
    newsTitleLabel.text = news;
    
    float duration = textLength / 100 ;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^
     {
         newsTitleLabel.frame = CGRectMake(-textLength, newsTitleLabel.frame.origin.y,textLength, newsTitleLabel.frame.size.height);
     } completion:^(BOOL finished)
     {
         [newsTitleLabel removeFromSuperview];
         [self downloadData];
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
