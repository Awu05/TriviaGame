//
//  ViewController.h
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"
#import "QuestionViewController.h"

@interface ViewController : UIViewController

// ==============================================
// JC's Properties
// ==============================================

// Jeopardy Board Title Labels
@property (weak, nonatomic) IBOutlet UILabel *catTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *catTitleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *catTitleLabel3;

// Question Buttons
// Row 1
@property (weak, nonatomic) IBOutlet UIButton *questionBtn1c200;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn1c400;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn1c600;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn1c800;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn1c1000;

// Scoreboard
// P1
@property (weak, nonatomic) IBOutlet CustomImageView *player1ProfImageView;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1NameLabel;

// P2
@property (weak, nonatomic) IBOutlet CustomImageView *player2ProfImageView;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2NameLabel;

//
// JC Properties End
@end

