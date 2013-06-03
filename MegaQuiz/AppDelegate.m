//
//  AppDelegate.m
//  MegaQuiz
//
//  Created by diallo on 3/06/13.
//  Copyright (c) 2013 Gurumades. All rights reserved.
//

#import "AppDelegate.h"
#import "SBJson.h"
#import "Question.h"

#import "QuestionViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadQuestions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    QuestionViewController *masterViewController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) loadQuestions{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"questions" withExtension:@"json"];
    NSString *str = [NSString stringWithContentsOfURL:url
                                             encoding:NSUTF8StringEncoding error:NULL];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSArray *array = [parser objectWithString:str];
    NSMutableArray *questions = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *item in array) {
        NSString *question = [item valueForKey:@"question"];
        NSArray *answers = [item valueForKey:@"answers"];
        int goodIdx = [[item valueForKey:@"good_ans"] intValue];
        int rand = arc4random() % array.count;
        Question *q = [[Question alloc] initWithQuestion:question
                                                 answers:answers
                                         goodAnswerIndex:goodIdx];
        q.sort = rand;
        
        [questions addObject:q];
    }
    
    [questions sortUsingComparator:^NSComparisonResult(Question *obj1, Question *obj2) {
        if (obj1.sort == obj2.sort) {
            return NSOrderedSame;
        }
        
        if (obj1.sort > obj2.sort) {
            return NSOrderedDescending;
        }
        
        
        return NSOrderedAscending;
    }];
    
    self.questions = questions;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
