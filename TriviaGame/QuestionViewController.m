//
//  QuestionViewController.m
//  TriviaGame
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Custom Back Button in Nav
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    // Change rendering mode to allow tint color
    buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:buttonImage forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    
    backBtn.frame = CGRectMake(0, 0, 25, 12);
    [backBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
