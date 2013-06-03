//
//  MasterViewController.m
//  MegaQuiz
//
//  Created by diallo on 3/06/13.
//  Copyright (c) 2013 Gurumades. All rights reserved.
//

#import "QuestionViewController.h"
#import "ResultViewController.h"

#import "AppDelegate.h"

@interface QuestionViewController () {
    
}
@end

@implementation QuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}
							
- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self updateDisplay];
}

- (void) updateDisplay{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    question = [delegate.questions objectAtIndex:_question_index];
    
    [self.ans1Btn addTarget:self action:@selector(onAns1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ans2Btn addTarget:self action:@selector(onAns2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ans3Btn addTarget:self action:@selector(onAns3Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.ans4Btn addTarget:self action:@selector(onAns4Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.questionLbl.text = question.question;
    
    int index = 0;
    for (; index <= 103; index++) {
        if (index == 4) {
            break;
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+index];
        [btn setTitle:[question.answers objectAtIndex:index] forState:UIControlStateNormal];
    }
}

- (void) checkGoodAnswer:(int) index{
    UIButton *btn = nil;
    if (![question isGoodAnswer:index]) {
        btn = (UIButton *)[self.view viewWithTag:100+index];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_red.png"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        badCount++;
    }else{
        goodCount++;
    }
    
    UIButton *good = (UIButton *)[self.view viewWithTag:100+question.good_answer];
    [good setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [good setBackgroundImage:[UIImage imageNamed:@"btn_green.png"] forState:UIControlStateNormal];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_white.png"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [good setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [good setBackgroundImage:[UIImage imageNamed:@"btn_white.png"] forState:UIControlStateNormal];
        
        _question_index++;
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (_question_index >= delegate.questions.count) {
            [self showResult];
        }else{
            [self updateDisplay];
        }
    });
}

- (void) showResult{
    ResultViewController *result = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:NULL];
    
    result.scoreValue = 100*((float)goodCount)/(goodCount + badCount);
    
    [self.navigationController pushViewController:result animated:YES];
    
    _question_index = 0;
}

- (void) onAns1Clicked{
    [self checkGoodAnswer:0];
}


- (void) onAns2Clicked{
    [self checkGoodAnswer:1];
}


- (void) onAns3Clicked{
    [self checkGoodAnswer:2];
}


- (void) onAns4Clicked{
    [self checkGoodAnswer:3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
