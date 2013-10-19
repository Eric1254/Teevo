//
//  QuizView.m
//  Teevo
//
//  Created by Capgemini on 12/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "QuizView.h"

@implementation QuizView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.question.text = [self.sourceData valueForKey:@"questiontext"];
        self.opt1.text = [[self.sourceData valueForKey:@"answertext"] objectAtIndex:0];
        self.opt2.text = [[self.sourceData valueForKey:@"answertext"] objectAtIndex:1];
        self.opt3.text = [[self.sourceData valueForKey:@"answertext"] objectAtIndex:2];
        self.opt4.text = [[self.sourceData valueForKey:@"answertext"] objectAtIndex:3];
    }
    return self;
}

@end
