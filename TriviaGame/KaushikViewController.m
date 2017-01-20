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
    self.title = @"Kaushik's Turn";
    self.navigationItem.hidesBackButton = YES;
    
    self.counterSecond = 10;
    
    // JC: These are responses Kaushik give
    self.responses = [NSArray arrayWithObjects:@"I don't know the answer...",
                                               @"I think I'm going to pass on this one.",
                                               @"Go ask Jesse.",
                                               @"No idea...",
                                               @"This question is below me.", nil];
    // Response Label
    self.kResponseLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.kResponseLabel.layer.borderWidth = 1.0;
    self.kResponseLabel.layer.cornerRadius = 5;
    
    // Randomized Responses
    NSInteger responseID = arc4random() % 6;
    NSString *answerString = @"";
    NSString *answer = @""; // needs to be updated with the right var
    if (responseID == 5) {
        answerString = [NSString stringWithFormat:@"This is easy, the answer is %@", answer];
    }
    else {
        answerString = [self.responses objectAtIndex:(int) responseID];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                   ^{
                       [self animateLabelShowText:answerString characterDelay:0.05];
                   });
    // Score Label
    self.scoreView.layer.cornerRadius = self.scoreView.frame.size.width / 2;
    self.scoreView.layer.borderWidth = 3.0f;
    self.scoreView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    // Timer
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
}

- (void)animateLabelShowText:(NSString*)newText characterDelay:(NSTimeInterval)delay
{
    [self.kResponseLabel setText:@""];
    
    for (int i=0; i<newText.length; i++)
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self.kResponseLabel setText:[NSString stringWithFormat:@"%@%C", self.kResponseLabel.text, [newText characterAtIndex:i]]];
                       });
        
        [NSThread sleepForTimeInterval:delay];
    }
}

-(void)timer {
    self.timerLabel.text = [NSString stringWithFormat:@"%d", self.counterSecond];
    self.counterSecond--;
    if (self.counterSecond == 0) {
        //do something
    }

}
    
-(void)popAllVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)continueBtnPrsd:(id)sender {
    [self popAllVC];
}

@end
