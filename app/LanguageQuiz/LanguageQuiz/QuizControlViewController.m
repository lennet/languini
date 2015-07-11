//
//  QuizControlViewController.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 23/05/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//


#import "QuizControlViewController.h"
#import "Sentence.h"
#import "Country.h"
#import "SentencesAggregator.h"
#import "LanguoidsAggregator.h"

#define maxDistance 5000
#define standardPoints 50

@interface QuizControlViewController ()
@property(nonatomic, retain) SentencesAggregator *sentencesAggregator;
@property(nonatomic, retain) LanguiodsAggregator *languiodsAggregator;
@property(nonatomic, retain) Sentence *curentSentence;
@property(strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property(strong, nonatomic) IBOutlet UILabel *lifesLabel;
@property(nonatomic) NSUInteger score;
@property(nonatomic) NSUInteger lifesLeft;
@end

@implementation QuizControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customInit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetScores];
    [self nextQuestion];
}

- (void)customInit {
    self.sentencesAggregator = [SentencesAggregator new];
    self.languiodsAggregator = [LanguiodsAggregator new];
}

- (void)resetScores {
    self.score = 0;
    self.lifesLeft = 5;
    [self updateLifeLabel:NO];
    [self updateScoreLabel:0];
}

- (IBAction)handleHomePressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didPressedExitButton)]) {
        [self.delegate didPressedExitButton];
    }
}

- (NSUInteger)pointsForCorrectAnswer {
    return standardPoints;
}

- (NSInteger)pointsForAnswerWithDistance:(CLLocationDistance)distance {
    NSInteger distanceInMeter = distance / 1000;
    return maxDistance - distanceInMeter;
}

- (void)updateScoreLabel:(NSUInteger)points {
    self.score += points;
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) self.score];
}

- (void)updateLifeLabel:(BOOL)lostLife {
    if (lostLife) {
        self.lifesLeft--;
    }

    self.lifesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) self.lifesLeft];
}

- (void)nextQuestion {
    if (self.lifesLeft == 0) {
        [self.delegate shouldFinishGame];
    } else {
        self.curentSentence = [self.sentencesAggregator getRandomSentence];
        if ([self.delegate respondsToSelector:@selector(shouldUpdateQuestionLabel:)]) {
            [self.delegate shouldUpdateQuestionLabel:[self getQuestionString]];
        }
        if (self.type == StandardQuiz && [self.delegate respondsToSelector:@selector(updateAnswers:)]) {
            [self.delegate updateAnswers:[self getAnswers]];
        }
    }
}

- (NSString *)getQuestionString {
    return [NSString stringWithFormat:@"%@\n(%@)", self.curentSentence.sentence, self.curentSentence.translation];
}

- (NSArray *)getAnswers {
    NSMutableArray *answerArray = [NSMutableArray arrayWithArray:@[self.curentSentence.languoid]];
    [answerArray addObjectsFromArray:[self.languiodsAggregator getRandomLangouidsWithOut:answerArray.firstObject andCount:3]];

    NSUInteger count = [answerArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t) remainingCount);
        [answerArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }

    return answerArray;
}

- (BOOL)isValidAnswer:(NSString *)selectedCountry andLocation:(CLLocation *)selectedLocation{

    for (Country *country in self.curentSentence.languoid.country) {

        if ([country.code isEqualToString:selectedCountry]) {
            [self updateScoreLabel:maxDistance];
            self.lifesLeft++;
            [self updateLifeLabel:YES];
            return YES;
        }
        
    }
    
    CLLocation *closestLocation = [self getClosestLocationForLocation:selectedLocation andLanguoid:self.curentSentence.languoid];
    
    CLLocationDistance distance = [selectedLocation distanceFromLocation:closestLocation];
    NSInteger newPoints = [self pointsForAnswerWithDistance:distance];
    
    if (newPoints > 0) {
        [self updateScoreLabel:newPoints];
    } else {
        [self updateLifeLabel:YES];
    }
    return NO;
}

- (CLLocation *)getClosestLocationForLocation:(CLLocation *)selectedLocation andLanguoid:(Languoid *)languoid {
    CLLocation *location;
    double minValue = MAXFLOAT;
    for (Country *country in languoid.country) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[country.latitude floatValue] longitude:[country.longitude floatValue]];
        CLLocationDistance distance = [selectedLocation distanceFromLocation:currentLocation];
        if (distance < minValue) {
            location = currentLocation;
            minValue = distance;
        }
    }
    return location;
}

- (BOOL)isValidAnswerWithLanguoid:(Languoid *)languoid {
    if ([self.curentSentence.languoid.key isEqualToString:languoid.key]) {
        [self updateScoreLabel:[self pointsForCorrectAnswer]];
        return YES;
    }
    [self updateLifeLabel:YES];
    return NO;
}

- (Languoid *)getCorrectLanguoid {
    return self.curentSentence.languoid;
}

- (CLLocation *)getCorrectLocationWithLocation:(CLLocation*)location{
    return [self getClosestLocationForLocation:location andLanguoid:self.curentSentence.languoid];
}

- (NSInteger)getScore {
    return self.score;
}

@end