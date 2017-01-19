//
//  JService.m
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "JService.h"

@implementation JService

- (instancetype) initWithInfo:(NSString *)catID
                     andTitle:(NSString *)title
                 andClueCount:(int)cluCount {
    self = [super init];
    if (self) {
        self.categoryID = catID;
        self.title = title;
        self.clueCount = cluCount;
    }
    return self;
}

@end
