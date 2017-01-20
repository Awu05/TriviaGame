//
//  KaushikViewController.h
//  TriviaGame
//
//  Created by Rael Kenny on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@interface KaushikViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property int counterSecond;

@property (strong, nonatomic) NSArray *responses;
@property (weak, nonatomic) IBOutlet CustomImageView *kProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *kResponseLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *scoreView;

- (IBAction)continueBtnPrsd:(id)sender;

@end
