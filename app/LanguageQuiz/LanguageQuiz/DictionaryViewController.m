//
//  DictionaryViewControllerTableViewController.m
//  LanguageQuiz
//
//  Created by Daniel  on 27.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DictionaryViewController.h"


@interface DictionaryViewController ()
@property(nonatomic, retain) NSArray *languiodsArray;
@property(nonatomic, strong) NSArray *searchResults;
@end


@implementation DictionaryViewController
@synthesize sectionBar;

- (void)setUpTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"DictionaryTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchResults = [NSMutableArray new];
    
    [self setUpTableView];
    [self setUpLanguiodsData];
}

- (void)setUpLanguiodsData {
    if (!_specialDataSource) {
        LanguiodsAggregator *dataAggregator = [LanguiodsAggregator new];
        NSArray *sortedData = [dataAggregator getLanguiodsData];
        [self createSectionArray:sortedData];
    }
    else {
        [self createSectionArray:_specialDataSource];
    }
    [self.tableView reloadData];
}

- (void)createSectionArray:(NSArray *)sortedLanguiods {

    NSArray *allLanguiods = sortedLanguiods;
    NSMutableArray *sectionArray = [NSMutableArray new];
    for (char a = 'a'; a <= 'z'; a++) {
        NSString *charString = [NSString stringWithFormat:@"%c", a];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name beginswith [c] %@", charString];
        NSArray *currentSection = [allLanguiods filteredArrayUsingPredicate:predicate];
        NSPredicate *negativePredicate = [NSCompoundPredicate notPredicateWithSubpredicate:predicate];
        allLanguiods = [allLanguiods filteredArrayUsingPredicate:negativePredicate];
        if (currentSection.count > 0) {
            [sectionArray addObject:currentSection];
        }
    }
    if (allLanguiods.count > 0) {
        [sectionArray addObject:allLanguiods];
    }

    self.languiodsArray = [NSArray arrayWithArray:sectionArray];

}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.specialDataSource && [_specialDataSource count] <= 20)
        return nil;
    return [self getSectionBar];
}

- (NSArray *)getSectionBar {
    if (!sectionBar) {
        NSMutableArray *mutableSectionBar = [NSMutableArray new];
        for (NSArray *sectionArray in self.languiodsArray) {
            Languoid *currentLanguoid = sectionArray.firstObject;
            if (!currentLanguoid.name) {
                [mutableSectionBar addObject:@"#"];
            } else {
                unichar firstChar = [currentLanguoid.name characterAtIndex:0];
                NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
                if ([letters characterIsMember:firstChar]) {
                    [mutableSectionBar addObject:[NSString stringWithFormat:@"%c", firstChar]];
                } else {
                    [mutableSectionBar addObject:@"#"];
                }
            }
        }
        sectionBar = [NSArray arrayWithArray:mutableSectionBar];
    }
    return sectionBar;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"";
    } else {
        Languoid *currentLanguoid = self.languiodsArray[section][0];
        if (!currentLanguoid.name) {
            return @"#";
        }
        unichar firstChar = [currentLanguoid.name characterAtIndex:0];
        NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
        if ([letters characterIsMember:firstChar]) {
            return [NSString stringWithFormat:@"%c", firstChar].uppercaseString;
        } else {
            return @"#";
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    else {
        return self.languiodsArray.count;
    }


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else {
        return ((NSMutableArray *) self.languiodsArray[section]).count;
    }


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"DictionaryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    Languoid *currentLanguoid;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        currentLanguoid = self.searchResults[indexPath.row];
    }
    else {
        currentLanguoid = self.languiodsArray[indexPath.section][indexPath.row];
    }

    cell.textLabel.text = currentLanguoid.name;

    NSString *alternateNamesString = [currentLanguoid.alternateNames componentsJoinedByString:@", "];
    cell.detailTextLabel.text = alternateNamesString.length > 0 ? alternateNamesString : @" ";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {

        Languoid *currentLanguoid = self.searchResults[indexPath.row];
        [self performSegueWithIdentifier:@"displayDetailView" sender:currentLanguoid];
    }
}

#pragma Search Methods


- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains [c] %@ OR ANY alternateNames contains [c] %@", searchText, searchText];

    NSMutableArray *mutableFiltredArray = [NSMutableArray new];

    for (NSArray *sectionArray in self.languiodsArray) {
        [mutableFiltredArray addObjectsFromArray:[sectionArray filteredArrayUsingPredicate:predicate]];
    }

    self.searchResults = [NSArray arrayWithArray:mutableFiltredArray];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[self.searchDisplayController.searchBar scopeButtonTitles][[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"displayDetailView"]) {

        DictionaryDetailViewController *detailViewController = (DictionaryDetailViewController *) segue.destinationViewController;
        Languoid *currentLanguoid;

        if ([sender isKindOfClass:[Languoid class]]) {
            currentLanguoid = sender;
        } else {
            UITableViewCell *selectedCell = sender;

            NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:selectedCell];
            currentLanguoid = self.languiodsArray[selectedIndexPath.section][selectedIndexPath.row];
        }
        detailViewController.languoid = currentLanguoid;
    }
}

@end
