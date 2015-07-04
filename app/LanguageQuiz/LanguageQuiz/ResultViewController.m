//
//  ResultViewController.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 10.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "ResultViewController.h"
#import "HighScoreHelper.h"
#import "HighScoreEntry.h"
#import "Preferences.h"

@interface ResultViewController ()

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet UITextField *nameInput;
@property(strong, nonatomic) NSArray *scoreEntries;
@property(strong, nonatomic) HighScoreHelper *scoreHelper;
@property(strong, nonatomic) Preferences *prefs;
@property(nonatomic) NSInteger newScoreIndex;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.newScoreIndex = -1;
    self.scoreHelper = [HighScoreHelper new];
    self.prefs = [Preferences new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.nameInput.leftView = paddingView;
    self.nameInput.leftViewMode = UITextFieldViewModeAlways;

    NSString *userName = [self.prefs getDefaultUserName];
    if (userName) {
        self.nameInput.text = userName;
    }

    [self loadScoreEntries];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scoreHelper addScore:self.newScore WithName:[self getCurrentName] forType:self.type];
    if (self.nameInput.text.length > 0) {
        [self.prefs setDefaultUserName:self.nameInput.text];
    }
}

- (void)loadScoreEntries {
    NSMutableArray *scores = [NSMutableArray new];
    NSArray *currentTopScores = [self.scoreHelper getTopScoreEntriesForType:self.type];
    if (currentTopScores.count > 0) {
        for (NSInteger i = 0; i < currentTopScores.count; i++) {
            HighScoreEntry *currentScore = currentTopScores[i];
            if ([currentScore.score integerValue] < self.newScore && self.newScoreIndex < 0) {
                [scores addObject:@(self.newScore)];
                self.newScoreIndex = i;
            } else if (scores.count < 10) {
                [scores addObject:currentScore];
            }
        }
    } else {
        [scores addObject:@(self.newScore)];
        self.newScoreIndex = 0;
    }
    self.scoreEntries = [NSArray arrayWithArray:scores];
}

- (NSString *)getCurrentName {
    if (self.nameInput.text.length > 0) {
        return self.nameInput.text;
    } else {
        return @"Unbekannt";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scoreEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scoreEntryCell"];
    NSString *scoreString;
    NSString *nameString;
    if (indexPath.row == self.newScoreIndex || [self.scoreEntries[indexPath.row] isKindOfClass:[NSNumber class]]) {
        scoreString = [NSString stringWithFormat:@"%li", (long) self.newScore];
        nameString = [self getCurrentName];
    } else {
        HighScoreEntry *currentEntry = self.scoreEntries[indexPath.row];
        scoreString = [currentEntry.score stringValue];
        nameString = currentEntry.name;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li. %@ %@", (long) indexPath.row + 1, nameString, scoreString];
    return cell;
}

#pragma mark - UITextField Delegaet

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.newScoreIndex >= 0) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.newScoreIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    return YES;
}

@end
