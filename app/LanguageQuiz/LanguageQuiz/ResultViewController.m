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
#import "ResultTableViewCell.h"

@interface ResultViewController ()

@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet UITextField *nameInput;
@property(strong, nonatomic) NSArray *scoreEntries;
@property(strong, nonatomic) HighScoreHelper *scoreHelper;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
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

    [self.finishButton setTitle:NSLocalizedString(@"resultView.finishButton.title", nil) forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.nameInput.placeholder = NSLocalizedString(@"resultView.nameInput.placeholder", nil);
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
    NSMutableArray *currentTopScores = [NSMutableArray arrayWithArray:[self.scoreHelper getTopScoreEntriesForType:self.type]];
    
    if (currentTopScores.count > 0) {
        for (NSInteger i = 0; i < currentTopScores.count; i++) {
            HighScoreEntry *currentScore = currentTopScores[i];
            if ([currentScore.score integerValue] < self.newScore && self.newScoreIndex < 0) {
                [currentTopScores insertObject:@(self.newScore) atIndex:i];
                self.newScoreIndex = i;
            }
        }
    } else {
        [currentTopScores addObject:@(self.newScore)];
        self.newScoreIndex = 0;
    }
    self.scoreEntries = [NSArray arrayWithArray:currentTopScores];
    
}

- (NSString *)getCurrentName {
    if (self.nameInput.text.length > 0) {
        return self.nameInput.text;
    } else {
        return NSLocalizedString(@"user.unknown", nil);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scoreEntryCell"];
    if(cell == nil){
        cell = [[ResultTableViewCell alloc]init];
    }
    NSString *scoreString;
    NSString *nameString;
    if(indexPath.row < [self.scoreEntries count]){
        if (indexPath.row == self.newScoreIndex || [self.scoreEntries[indexPath.row] isKindOfClass:[NSNumber class]]) {
            scoreString = [NSString stringWithFormat:@"%li", (long) self.newScore];
            nameString = [self getCurrentName];
        } else {
            HighScoreEntry *currentEntry = self.scoreEntries[indexPath.row];
            scoreString = [currentEntry.score stringValue];
            nameString = currentEntry.name;
        }

        cell.rankingLabel.text = [NSString stringWithFormat:@"%li", (long) indexPath.row + 1];
        cell.scoreLabel.text = scoreString;
        cell.nameLabel.text = nameString;

    }
    else{
        cell.rankingLabel.text = [NSString stringWithFormat:@"%li", (long) (indexPath.row +1)];
        cell.nameLabel.text = @" 0 ";
        cell.scoreLabel.text = @" ";
    }
    if(indexPath.row == self.newScoreIndex){
        cell.backgroundColor = [UIColor colorWithRed:0.295 green:0.695 blue:0.900 alpha:0.970];
    }
    
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
