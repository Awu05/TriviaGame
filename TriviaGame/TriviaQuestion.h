//
//  TriviaQuestion.h
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TriviaQuestion : NSObject

@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *answer;
@property int value;


- (instancetype)initWithQuestion: (NSString*) question
                       andAnswer: (NSString*) answer
                   andPointValue: (int) points;

@end
