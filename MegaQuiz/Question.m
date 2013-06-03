//
//  Question.m
//  MegaQuiz
//
//  Created by diallo on 3/06/13.
//  Copyright (c) 2013 Gurumades. All rights reserved.
//

#import "Question.h"

@implementation Question


- (id)initWithQuestion:(NSString *) q
               answers:(NSArray *) answers
       goodAnswerIndex:(int) index{
    if (self = [super init]) {
        self.question = q;
        self.answers = answers;
        self.good_answer = index;
    }
    
    return self;
}

- (BOOL) isGoodAnswer:(int) index{
    return index == self.good_answer;
}

@end
