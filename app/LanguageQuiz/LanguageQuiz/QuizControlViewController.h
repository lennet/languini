//
//  QuizControlViewController.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 23/05/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Languoid.h"

typedef enum {
    StandardQuiz,
    GeoQuiz
} QuizType;


@protocol QuizControlViewControllerDelegate <NSObject>

- (void)shouldFinishGame;

- (void)didPressedExitButton;

- (void)shouldUpdateQuestionLabel:(NSString *)question;

@optional
- (void)updateAnswers:(NSArray *)answerArray;

@end


@interface QuizControlViewController : UIViewController

@property(strong, nonatomic) id delegate;
@property(nonatomic) QuizType type;

- (BOOL)isValidAnswer:(NSString *)selectedCountry andLocation:(CLLocation*)selectedLocation;
- (BOOL)isValidAnswerWithLanguoid:(Languoid *)languoid;

- (void)nextQuestion;

- (CLLocation *)getCorrectLocationWithLocation:(CLLocation*)location;

- (Languoid *)getCorrectLanguoid;

- (NSInteger)getScore;

- (void)resetScores;

@end
