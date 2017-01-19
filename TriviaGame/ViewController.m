//
//  ViewController.m
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//
//
//

#import "ViewController.h"
#include <stdlib.h>
#import "KaushikViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Andy
    self.jServiceArray = [[NSMutableArray alloc] init];
    self.questionsArry = [[NSMutableArray alloc] init];
    [self getJServiceCategory];

    // Andy End
    
    // ==============================================
    // JC
    // ==============================================
    
    // Nav setup
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.title = @"Kaushikpardy";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(gameReset)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testK)];
    
    
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

-(void) testK {
    // Testing KaushikVC
    KaushikViewController *kVC = [[KaushikViewController alloc]init];
    [self.navigationController pushViewController:kVC animated:YES];
}

// This method triggers the question VC
-(void) questionBtnPrsd {
    QuestionViewController *questionVC = [[QuestionViewController alloc]init];
    // Question *questionSelected = ;
    // questionVC.title = @"Category for Score";
    [self.navigationController pushViewController:questionVC animated:YES];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// JC Methods End

// Andy Stuff

- (void) startGame {
    [self generateRandNum:1 :10 ];
    
    for (int i = 0; i < 3; i++) {
        JService *category;
        int num = 0;
        switch (i) {
            case 0:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category1Title.text = category.title;
                break;
            case 1:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category2Title.text = category.title;
                break;
            case 2:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category3Title.text = category.title;
                break;
            default:
                break;
        }
    }
}

- (void) getJServiceCategory {
    NSString *jServiceURL = @"http://jservice.io/api/categories?count=10";
    
    // 1
    NSString *dataUrl = jServiceURL;
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self parseJServiceData:data];
                                                  
                                              });
                                              
                                          }];
    
    // 3
    [downloadTask resume];
}

- (void) parseJServiceData: (NSData*) data {
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    for (NSDictionary *choice in json) {
        NSString *catID = [choice objectForKey:@"id"];
        NSString *title = [choice objectForKey:@"title"];
        int clueCount = [[choice objectForKey:@"clues_count"] intValue];
        
        JService *newEntry = [[JService alloc] initWithInfo:catID andTitle:title andClueCount:clueCount];
        
        [self.jServiceArray addObject:newEntry];
    }
    
    [self startGame];
    //NSLog(@"%@\n Count: %lu", self.jServiceArray, (unsigned long)[self.jServiceArray count]);
    
    //[self getQuestion:self.jServiceArray[1]];
}

- (void) getQuestion: (JService*) category {
    
    NSString *questionURL = [NSString stringWithFormat:@"http://jservice.io/api/category?id=%@", category.categoryID];;
    
    // 1
    NSString *dataUrl = questionURL;
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self parseQuestion:data];
                                                  
                                              });
                                              
                                          }];
    
    // 3
    [downloadTask resume];
    
}

- (void) parseQuestion: (NSData*) data {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    NSArray* questionArr = [json objectForKey:@"clues"];
    
    for (NSDictionary *element in questionArr) {
        NSString *question = [element objectForKey:@"question"];
        NSString *answer = [element objectForKey:@"answer"];
        int points = [[element objectForKey:@"value"] intValue];
        
        TriviaQuestion *newQuestion = [[TriviaQuestion alloc] initWithQuestion:question andAnswer:answer andPointValue:points];
        
        [self.questionsArry addObject:newQuestion];
    }
    
    //NSLog(@"%@\n Count: %lu", self.questionsArry, (unsigned long)[self.questionsArry count]);
    
    //TriviaQuestion *test = self.questionsArry[0];
    //NSLog(@"Question: %@\nAnswer:%@\nValue:%d", test.question, test.answer, test.value);
    
}

-(void) generateRandNum :(int)rangeLow :(int)rangeHigh{
    NSMutableArray *unqArray=[[NSMutableArray alloc] init];
    int randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
    int counter=0;
    while (counter<rangeHigh-rangeLow) {
        if (![unqArray containsObject:[NSNumber numberWithInt:randNum]]) {
            [unqArray addObject:[NSNumber numberWithInt:randNum]];
            counter++;
        }else{
            randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
        }
        
    }
    self.randArray = unqArray;
}

// Andy End

- (IBAction)cat1FirstBtn:(id)sender {
}

- (IBAction)cat1SecondBtn:(id)sender {
}

- (IBAction)cat1ThirdBtn:(id)sender {
}

- (IBAction)cat1FourthBtn:(id)sender {
}

- (IBAction)cat1FifthBtn:(id)sender {
}
- (IBAction)cat2FirstBtn:(id)sender {
}

- (IBAction)cat2SecondBtn:(id)sender {
}

- (IBAction)cat2ThirdBtn:(id)sender {
}

- (IBAction)cat2FourthBtn:(id)sender {
}

- (IBAction)cat2FifthBtn:(id)sender {
}
- (IBAction)cat3FirstBtn:(id)sender {
}

- (IBAction)cat3SecondBtn:(id)sender {
}

- (IBAction)cat3ThirdBtn:(id)sender {
}

- (IBAction)cat3FourthBtn:(id)sender {
}

- (IBAction)cat3FifthBtn:(id)sender {
}
@end
