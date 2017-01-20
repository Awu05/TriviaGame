//
//  QuestionViewController.h
//  TriviaGame
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *questionView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitAnswerBtn;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *topView;

// Timer
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property int counterSecond;

@property (nonatomic, retain) NSString *question;

- (IBAction)submitAnswerBtn:(id)sender;

@end
