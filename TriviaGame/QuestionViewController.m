//
//  QuestionViewController.m
//  TriviaGame
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "QuestionViewController.h"
#import "KaushikViewController.h"

#define kOFFSET_FOR_KEYBOARD 200

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.questionLabel.text = self.question;
    
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
    self.timerz = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    // Add gesture recognition for exiting edit mode
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.topView addGestureRecognizer:tap];
}

- (IBAction)submitAnswerBtn:(id)sender {
    if([self.correctAnswer.lowercaseString isEqualToString:self.answerTextField.text.lowercaseString]) {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"Correct!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerCorrect" object:nil];
                                            
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
        
        [alerController addAction:confirmAction];
        
        [self presentViewController:alerController animated:YES completion:nil];
    }
    else {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"Incorrect!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerIncorrect" object:nil];
                                            
                                            [self.timerz invalidate];
                                            self.timerz = nil;
                                            
                                            KaushikViewController *kVC = [[KaushikViewController alloc]init];
                                            [self.navigationController pushViewController:kVC animated:YES];
                                            
                                        }];
        
        [alerController addAction:confirmAction];
        
        [self presentViewController:alerController animated:YES completion:nil];
    }
    
}


-(void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)dismissKeyboard
{
    [self.answerTextField resignFirstResponder];
}

// Keyboard Float

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = - 192;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0;
        self.view.frame = f;
    }];
}


@end
