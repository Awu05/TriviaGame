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
    // Do any additional setup after loading the view from its nib.
    
    
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
