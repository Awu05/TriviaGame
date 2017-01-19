//
//  TriviaQuestion.m
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "TriviaQuestion.h"

@implementation TriviaQuestion


- (instancetype) initWithQuestion:(NSString *)question
                        andAnswer:(NSString *)answer
                    andPointValue:(int)points {
    
    self = [super init];
    if (self) {
        self.question = question;
        self.answer = answer;
        self.value = points;
    }
    return self;
}

@end
