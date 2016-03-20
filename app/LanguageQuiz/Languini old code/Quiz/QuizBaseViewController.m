//
//  QuizBaseViewController.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 25/05/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "QuizBaseViewController.h"
#import "ResultViewController.h"

@interface QuizBaseViewController () <QuizControlViewControllerDelegate>


@end

@implementation QuizBaseViewController
@synthesize quizControlViewController = _quizControlViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark QuizControlViewControllerDelegate

- (void)shouldFinishGame {
    [NSException exceptionWithName:@"Abstract Implementation" reason:@"Method Implementation is missing!" userInfo:nil];
}

- (void)didPressedExitButton {
    [NSException exceptionWithName:@"Abstract Implementation" reason:@"Method Implementation is missing!" userInfo:nil];
}

- (void)shouldUpdateQuestionLabel:(NSString *)question {
    [NSException exceptionWithName:@"Abstract Implementation" reason:@"Method Implementation is missing!" userInfo:nil];
}


#pragma mark - Navigation

- (void)setUpQuizController {
    _quizControlViewController.delegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[QuizControlViewController class]]) {
        _quizControlViewController = segue.destinationViewController;
        [self setUpQuizController];

    } else if ([segue.destinationViewController isKindOfClass:[ResultViewController class]]) {
        ResultViewController *resultViewController = [segue destinationViewController];
        resultViewController.type = self.quizControlViewController.type;
        resultViewController.newScore = [self.quizControlViewController getScore];
    }
}

@end
