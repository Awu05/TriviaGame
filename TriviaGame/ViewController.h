//
//  ViewController.h
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriviaQuestion.h"
#import "JService.h"

@interface ViewController : UIViewController

@property (retain, nonatomic) NSMutableArray *questionsArry;
@property (retain, nonatomic) NSMutableArray *jServiceArray;

- (void) getJServiceCategory;
- (void) parseJServiceData: (NSData*) data;
- (void) getQuestion: (JService*) category;
- (void) parseQuestion: (NSData*) data;

@end

