//
//  QuestionViewController.m
//  TriviaGame
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "QuestionViewController.h"
#import "KaushikViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Custom Nav Buttons
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:buttonImage forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    
    backBtn.frame = CGRectMake(0, 0, 25, 12);
    [backBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    // Timer
    self.counterSecond = 20;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
}


-(void)timer {
    self.timerLabel.text = [NSString stringWithFormat:@"%d", self.counterSecond];
    self.counterSecond--;
    if (self.counterSecond == 0) {
        KaushikViewController *kVC = [[KaushikViewController alloc]init];
        [self.navigationController pushViewController:kVC animated:YES];

    }
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
