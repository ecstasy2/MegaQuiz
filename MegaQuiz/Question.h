//
//  Question.h
//  MegaQuiz
//
//  Created by diallo on 3/06/13.
//  Copyright (c) 2013 Gurumades. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject


@property(copy, nonatomic) NSString *question;
@property(copy, nonatomic) NSArray *answers;
@property(nonatomic) int good_answer;
@property(nonatomic) int sort;

- (id)initWithQuestion:(NSString *) q
               answers:(NSArray *) answers
       goodAnswerIndex:(int) index;

- (BOOL) isGoodAnswer:(int) index;
@end
