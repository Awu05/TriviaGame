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
    
    // Andy
    self.jServiceArray = [[NSMutableArray alloc] init];
    self.questionsArry = [[NSMutableArray alloc] init];
    
    [self getJServiceCategory];
    // Andy End
    
    
    // JC
    // Player Profile Image
    self.player1ProfImageView.image = [UIImage imageNamed:@"kaushik-biswas"];

    
    // JC End
}

// ================================================================================================
//
#pragma mark - JC's Methods
//
// ================================================================================================

// JC Methods End

// Andy Stuff
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
// Andy End

@end
