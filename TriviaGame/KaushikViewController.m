//
//  KaushikViewController.m
//  TriviaGame
//
//  Created by Rael Kenny on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "KaushikViewController.h"

@interface KaushikViewController ()

@end

@implementation KaushikViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.counterSecond = 10;
    
    // JC: These are responses Kaushik give
    self.responses = [NSArray arrayWithObjects:@"I don't know the answer...",
                                               @"I think I'm going to pass on this one.",
                                               @"No idea...",
                                               @"This question is below me", nil];
    // Response Label
    self.kResponseLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.kResponseLabel.layer.borderWidth = 1.0;
    self.kResponseLabel.layer.cornerRadius = 5;
    
    // Randomized Responses
    NSInteger responseID = arc4random() % 5;
    NSString *answerString = @""; // needs to be updated with the right var
    if (responseID == 4) {
        self.kResponseLabel.text = [NSString stringWithFormat:@"This is easy, the answer is %@", answerString];
    }
    else {
        self.kResponseLabel.text = [self.responses objectAtIndex:(int) responseID];
    }

    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
}


-(void)timer {
    self.timerLabel.text = [NSString stringWithFormat:@"%d", self.counterSecond];
    self.counterSecond--;
    if (self.counterSecond == 0) {
        //do something
    }

}
    


@end
