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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start:) name:@"gameStart" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startCat1:) name:@"category1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startCat2:) name:@"category2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startCat3:) name:@"category3" object:nil];
    
    [self generateRandNum:0 :10 ];
    
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
    JService *category = [[JService alloc] init];
    int num = 0;
    for (int i = 0; i < 3; i++) {
        
        switch (i) {
            case 0:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category1Title.text = category.title;
                self.category1 = category;
                break;
            case 1:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category2Title.text = category.title;
                self.category2 = category;
                break;
            case 2:
                num = [self.randArray[i] intValue];
                category = self.jServiceArray[num];
                self.category3Title.text = category.title;
                self.category3 = category;
                break;
            default:
                break;
        }

    }
    
    [self getQuestion:self.category1];
    self.cat1Start = true;
    
    
    
}

- (void)startCat1:(NSNotification *)note {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"category1"
                                                  object:nil];
    self.category1Array = [[NSMutableArray alloc] initWithArray:self.questionsArry];
    
    [self getQuestion:self.category2];
    self.cat2Start = true;
    self.cat1Start = false;
    
}

- (void)startCat2:(NSNotification *)note {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"category2"
                                                  object:nil];
    self.category2Array = [[NSMutableArray alloc] initWithArray:self.questionsArry];
    
    [self getQuestion:self.category3];
    self.cat3Start = true;
    self.cat2Start = false;
}

- (void)startCat3:(NSNotification *)note {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"category3"
                                                  object:nil];
    self.category3Array = [[NSMutableArray alloc] initWithArray:self.questionsArry];
    self.cat3Start = false;
}

- (void) getJServiceCategory {
    NSString *jServiceURL = @"http://jservice.io/api/categories?count=20";
    
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
        int clueCount = 0;
        if([choice objectForKey:@"clues_count"] != nil){
            clueCount = [[choice objectForKey:@"clues_count"] intValue];
        }
        else {
            clueCount = 1;
        }
        
        JService *newEntry = [[JService alloc] initWithInfo:catID andTitle:title andClueCount:clueCount];
        
        //NSLog(@"categoryID: %@\nTitle:%@\nClues Count:%d\n", newEntry.categoryID, newEntry.title, newEntry.clueCount);
        
        [self.jServiceArray addObject:newEntry];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStart" object:nil];
    
    //NSLog(@"%@\n Count: %lu", self.jServiceArray, (unsigned long)[self.jServiceArray count]);
    
    //[self getQuestion:self.jServiceArray[1]];
}

- (void)start:(NSNotification *)note {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"gameStart"
                                                  object:nil];
    [self startGame];
}

- (void) getQuestion: (JService*) category {
    
    NSString *questionURL = [NSString stringWithFormat:@"http://jservice.io/api/category?id=%@", category.categoryID];
    
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
    NSLog(@"QuestionArray Count: %lu\n", (unsigned long)[questionArr count]);
    
    if([self.questionsArry count] > 0) {
        NSLog(@"Clearing Questions Array");
        [self.questionsArry removeAllObjects];
    }
    
    
    for (NSDictionary *element in questionArr) {
        NSString *question = [element objectForKey:@"question"];
        NSString *answer = [element objectForKey:@"answer"];
        int points = 0;
        
        @try {
            points = [[element objectForKey:@"value"] intValue];
        }
        @catch (NSException *exception) {
            NSLog(@"**Error: %@", exception.reason);
            points = 100;
        }
        
        
        TriviaQuestion *newQuestion = [[TriviaQuestion alloc] initWithQuestion:question andAnswer:answer andPointValue:points];
        
        [self.questionsArry addObject:newQuestion];
    }
    
    if(self.cat1Start == true) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"category1" object:nil];
    }
    
    if(self.cat2Start == true) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"category2" object:nil];
    }
    
    if(self.cat3Start == true) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"category3" object:nil];
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
    //NSLog(@"Random Array: %@", unqArray);
    self.randArray = unqArray;
}

// Andy End

- (IBAction)cat1FirstBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category1Array[0];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat1SecondBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category1Array[1];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat1ThirdBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category1Array[2];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat1FourthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category1Array[3];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat1FifthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category1Array[4];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}
- (IBAction)cat2FirstBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category2Array[0];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat2SecondBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category2Array[1];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat2ThirdBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category2Array[2];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat2FourthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category2Array[3];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat2FifthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category2Array[4];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}
- (IBAction)cat3FirstBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category3Array[0];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat3SecondBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category3Array[1];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat3ThirdBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category3Array[2];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat3FourthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category3Array[3];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

- (IBAction)cat3FifthBtn:(id)sender {
    self.qVC = [[QuestionViewController alloc] init];
    self.question = self.category3Array[4];
    self.qVC.question = self.question.question;
    
    [self.navigationController
     pushViewController:self.qVC
     animated:YES];
}

@end
