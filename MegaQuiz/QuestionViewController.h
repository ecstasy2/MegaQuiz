//
//  MasterViewController.h
//  MegaQuiz
//
//  Created by diallo on 3/06/13.
//  Copyright (c) 2013 Gurumades. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@class DetailViewController;

@interface QuestionViewController : UIViewController
{
    Question *question;
    int goodCount;
    int badCount;
}

@property int question_index;

@property(strong) IBOutlet UILabel *questionLbl;
@property(strong) IBOutlet UIButton *ans1Btn;
@property(strong) IBOutlet UIButton *ans2Btn;
@property(strong) IBOutlet UIButton *ans3Btn;
@property(strong) IBOutlet UIButton *ans4Btn;


@end
