//
//  ViewController.m
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // ==============================================
    // JC
    // ==============================================
    
    // Nav setup
    self.title = @"Kaushikpardy";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(gameReset)];
    
    
    // Player Profile Image
    self.player1ProfImageView.image = [UIImage imageNamed:@"user"];
    self.player2ProfImageView.image = [UIImage imageNamed:@"kaushik-biswas"];

    
    // JC End
}

// ================================================================================================
//
#pragma mark - JC's Methods
//
// ================================================================================================

-(void) gameReset {
    // Reset the game
}

// This method triggers the question VC
-(void) questionBtnPrsd {
    QuestionViewController *questionVC = [[QuestionViewController alloc]init];
    // Question *questionSelected = ;
    // questionVC.title = @"Category for Score";
    [self.navigationController pushViewController:questionVC animated:YES];
    
}
// JC Methods End
@end
