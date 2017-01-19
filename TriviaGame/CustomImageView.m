//
//  CustomImageView.m
//  TriviaGame
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 TrivGame. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder: coder];
    
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 3.0f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    return self;
}

@end
