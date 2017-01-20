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

// Timer
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property int counterSecond;

@end
