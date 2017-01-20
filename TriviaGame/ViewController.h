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
#import "TriviaQuestion.h"
#import "JService.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

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
@property (strong, nonatomic) NSString *playerName;
@property (weak, nonatomic) IBOutlet CustomImageView *player1ProfImageView;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1NameLabel;

// P2
@property (weak, nonatomic) IBOutlet CustomImageView *player2ProfImageView;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2NameLabel;

//
// JC Properties End

// Andy Stuff
@property (retain, nonatomic) NSMutableArray *questionsArry;
@property (retain, nonatomic) NSMutableArray *jServiceArray;

@property (retain, nonatomic) NSMutableArray *randArray;

- (void) getJServiceCategory;
- (void) parseJServiceData: (NSData*) data;
- (void) getQuestion: (JService*) category;
- (void) parseQuestion: (NSData*) data;

@property (weak, nonatomic) IBOutlet UILabel *category1Title;
- (IBAction)cat1FirstBtn:(id)sender;
- (IBAction)cat1SecondBtn:(id)sender;
- (IBAction)cat1ThirdBtn:(id)sender;
- (IBAction)cat1FourthBtn:(id)sender;
- (IBAction)cat1FifthBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *category2Title;
- (IBAction)cat2FirstBtn:(id)sender;
- (IBAction)cat2SecondBtn:(id)sender;
- (IBAction)cat2ThirdBtn:(id)sender;
- (IBAction)cat2FourthBtn:(id)sender;
- (IBAction)cat2FifthBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *category3Title;
- (IBAction)cat3FirstBtn:(id)sender;
- (IBAction)cat3SecondBtn:(id)sender;
- (IBAction)cat3ThirdBtn:(id)sender;
- (IBAction)cat3FourthBtn:(id)sender;
- (IBAction)cat3FifthBtn:(id)sender;





// Andy End
@end

