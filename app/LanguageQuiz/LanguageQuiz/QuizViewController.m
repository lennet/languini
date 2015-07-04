//
//  QuizViewController.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 25.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "QuizViewController.h"

#define delay 1

@interface QuizViewController ()
@property(strong, nonatomic) IBOutlet UILabel *questionLabel;
@property(strong, nonatomic) IBOutlet UIButton *answerButton0;
@property(strong, nonatomic) IBOutlet UIButton *answerButton1;
@property(strong, nonatomic) IBOutlet UIButton *answerButton2;
@property(strong, nonatomic) IBOutlet UIButton *answerButton3;
@property(strong, nonatomic) NSArray *answers;
@property(strong, nonatomic) NSArray *buttonArray;

@end

@implementation QuizViewController

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpButtons];
}

- (void)setUpButtons {
    self.buttonArray = @[self.answerButton0, self.answerButton1, self.answerButton2, self.answerButton3];
    for (UIButton *button in self.buttonArray) {
        button.titleLabel.numberOfLines = 2;
    }
}

- (void)setButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.buttonArray) {
        button.enabled = enabled;
    }
}

- (void)resetColors {
    for (NSInteger i = 0; i < self.buttonArray.count; i++) {
        [self setColor:[UIColor darkGrayColor] forButton:self.buttonArray[i] withLangouid:self.answers[i]];
    }
}

- (void)hightlightCorrectAnswerWithLanuoid:(Languoid *)languoid {
    for (UIButton *button in self.buttonArray) {
        Languoid *currentLanguoid = self.answers[button.tag];
        if ([currentLanguoid.key isEqualToString:languoid.key]) {
            [self setColor:[UIColor colorWithRed:139 / 255.0 green:229 / 255.0 blue:48 / 255.0 alpha:1] forButton:button withLangouid:currentLanguoid];
            return;
        }
    }
}

- (IBAction)handleAnswerButtonPressed:(UIButton *)sender {
    [self setButtonsEnabled:NO];
    [self validateAnswerForIndex:sender.tag];
}

- (void)validateAnswerForIndex:(NSUInteger)index {
    UIButton *selectedButton = self.buttonArray[index];
    // can be improved
    if ([self.quizControlViewController isValidAnswerWithLanguoid:self.answers[index]]) {
        [self setColor:[UIColor colorWithRed:56 / 255.0 green:237 / 255.0 blue:56 / 255.0 alpha:1] forButton:selectedButton withLangouid:self.answers[index]];
    } else {
        [self setColor:[UIColor colorWithRed:228 / 255.0 green:31 / 255.0 blue:54 / 255.0 alpha:1] forButton:selectedButton withLangouid:self.answers[index]];
        [self hightlightCorrectAnswerWithLanuoid:[self.quizControlViewController getCorrectLanguoid]];
    }
    [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:delay];
}

- (void)setColor:(UIColor *)color forButton:(UIButton *)button withLangouid:(Languoid *)languoid {
    NSMutableAttributedString *attributedTitleString = [[NSMutableAttributedString alloc] initWithAttributedString:button.titleLabel.attributedText];
    NSString *titleString = [attributedTitleString string];
    NSRange languageNameRange = [titleString rangeOfString:languoid.name];
    [attributedTitleString addAttribute:NSForegroundColorAttributeName value:color range:languageNameRange];
    [button setAttributedTitle:attributedTitleString forState:UIControlStateNormal];
}

- (NSAttributedString *)getButtonTitleFromLanguoid:(Languoid *)languoid {
    NSString *languageName = languoid.name;
    NSString *countries = [languoid.countries componentsJoinedByString:@", "];

    NSString *fullString = [NSString stringWithFormat:@"%@\n%@", languageName, countries];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullString];

    NSRange countriesRange = [fullString rangeOfString:countries];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:self.answerButton0.titleLabel.font.fontName size:self.answerButton0.titleLabel.font.pointSize - 10] range:countriesRange];

    return attributedString;
}

- (void)nextQuestion {
    [self resetColors];
    [self.quizControlViewController nextQuestion];
}

#pragma Mark QuizControlViewControllerDelegate 

- (void)shouldUpdateQuestionLabel:(NSString *)question {
    self.questionLabel.text = question;
    [self setButtonsEnabled:YES];
}

- (void)shouldFinishGame {
    [self performSegueWithIdentifier:@"gameResultSegue" sender:nil];
}

- (void)didPressedExitButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)updateAnswers:(NSArray *)answerArray {
    NSAssert(answerArray.count == 4, @"Wrong Number of Answers!");
    for (NSInteger i = 0; i < answerArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        [button setAttributedTitle:[self getButtonTitleFromLanguoid:answerArray[i]] forState:UIControlStateNormal];
    }
    self.answers = answerArray;
}

@end
