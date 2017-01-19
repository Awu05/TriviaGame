//
//  JService.h
//  TriviaGame
//
//  Created by Andy Wu on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JService : NSObject

@property (retain, nonatomic) NSString *categoryID;
@property (retain, nonatomic) NSString *title;
@property int clueCount;

- (instancetype)initWithInfo: (NSString*) catID
                    andTitle: (NSString*) title
                andClueCount: (int) cluCount;


@end
