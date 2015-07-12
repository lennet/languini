//
//  DictionaryDetailViewController.m
//  LanguageQuiz
//
//  Created by Daniel  on 20.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DictionaryDetailViewController.h"
#import "Sentence.h"
#import "Country.h"
#import "SentecesPageViewController.h"
#import "SectionHeaderCell.h"
#import "GlottoViewController.h"
#import "Reachability.h"

#define standardDistance 20
#define sectionHeaderHeight 44


@implementation DictionaryDetailViewController
@synthesize mapView, titleArray, valueArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDataSource];
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if ((toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
        self.offlineView.contentMode = UIViewContentModeScaleAspectFill;
        self.offlineView.transform = CGAffineTransformMakeScale(1, 1);
        NSLog(@"Portrait");
    } else {
        self.offlineView.transform = CGAffineTransformMakeScale(2, 2);
        NSLog(@"Landscape");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    self.title = self.languoid.name;

    [self.glottologButton setTitle:[NSString stringWithFormat:@"Glottlog - %@", [self.languoid valueForKey:@"key"]] forState:UIControlStateNormal];

    [self setUpTableView];
    [self setUpSentenceScrollView];
    [self setUpCountrySelection];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.wikipedia.com"];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        //  [self.offlineView setHidden:false];
        [self.offlineView setAlpha:CGFLOAT_MAX];
        self.offlineView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [self.rightCountryButton setHidden:true];
        [self.leftCountryButton setHidden:true];
        [self.glottologButton setHidden:true];
    } else {
        [self.offlineView setAlpha:CGFLOAT_MIN];
        [self.rightCountryButton setHidden:false];
        [self.leftCountryButton setHidden:false];
        [self.glottologButton setHidden:false];
    }
    [self checkButtonAvailability];
}

- (void)setUpDataSource {
    NSMutableArray *tmpTitle = [NSMutableArray new];
    NSMutableArray *tmpValues = [NSMutableArray new];
    if (self.languoid.name) {
        [tmpTitle addObject:@"Name"];
        [tmpValues addObject:@[self.languoid.name]];

    }
    if (((NSArray *)self.languoid.alternateNames).count > 0) {
        [tmpTitle addObject:@"Alternate Names"];
        [tmpValues addObject:self.languoid.alternateNames];
    }

    if (self.languoid.country.count > 0) {
        [tmpTitle addObject:@"Countries"];
        NSMutableArray *countriesArray = [NSMutableArray new];
        for (Country *country in self.languoid.country) {
            NSString *countryName;
            if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"de"] && country.nameDe) {
                countryName = country.nameDe;
            } else {
                countryName = country.name;
            }
            [countriesArray addObject:countryName];
        }
        [tmpValues addObject:countriesArray];
    }
    
    if (((NSArray *)self.languoid.dialects).count > 0) {
        [tmpTitle addObject:@"Dialects"];
        [tmpValues addObject:self.languoid.dialects];
    }
    if (self.languoid.lanugageStatus) {
        [tmpTitle addObject:@"Language Status"];
        [tmpValues addObject:@[self.languoid.lanugageStatus]];
    }
    if (self.languoid.population) { // population
        [tmpTitle addObject:@"Population"];
        [tmpValues addObject:@[self.languoid.population]];
    }
    if (self.languoid.locationDescription) { //location
        [tmpTitle addObject:@"Location Description"];
        [tmpValues addObject:@[self.languoid.locationDescription]];
    }
    if (self.languoid.iso6393) { // iso
        [tmpTitle addObject:@"ISO 6393 Code"];
        [tmpValues addObject:@[self.languoid.iso6393]];
    }
    if (((NSArray *)self.languoid.classification).count > 0) {
        [tmpTitle addObject:@"Classification"];
        [tmpValues addObject:self.languoid.classification];
    }
    titleArray = [[NSArray alloc] initWithArray:tmpTitle];
    valueArray = [[NSArray alloc] initWithArray:tmpValues];
}

- (void)setUpCountrySelection {
    if (self.languoid.country.count != 0) {
        self.currentCountryIndex = 0;
        [self updateCountrySelection];
    }
}

- (void)checkButtonAvailability {
    self.leftCountryButton.hidden = self.currentCountryIndex == 0;
    self.rightCountryButton.hidden = self.currentCountryIndex == [self.languoid.country allObjects].count - 1;
}

- (void)updateCountrySelection {
    [self checkButtonAvailability];
    Country *currentCountry = [self.languoid.country allObjects][self.currentCountryIndex];

    if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"de"] && currentCountry.nameDe) {
        self.countryLabel.text = currentCountry.nameDe;
    } else {
        self.countryLabel.text = currentCountry.name;
    }

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([currentCountry.latitude floatValue], [currentCountry.longitude floatValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2000000, 2000000);
    
    [mapView setRegion:region animated:YES];

}

- (void)setUpTableView {
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];

    [self.glottologButton layoutIfNeeded];

    self.infoContainerHeight.constant = self.tableView.contentSize.height + (CGRectGetMaxY(self.glottologButton.frame) - CGRectGetMaxY(self.tableView.frame));
}

- (void)setUpSentenceScrollView {
    [self.sentencesScrollView layoutIfNeeded];
    self.sentencesScrollView.pagingEnabled = YES;
    if (self.languoid.sentence.count > 0) {
        for (Sentence *sentence in self.languoid.sentence) {
            SentecesPageViewController *pageViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"SentecesPageViewController"];

            UIView *pageView = pageViewController.view;
            pageView.frame = self.sentencesScrollView.bounds;
            [self.sentencesScrollView addSubview:pageView];
            pageViewController.sentenceLabel.text = sentence.sentence;
            pageViewController.translationLabel.text = [NSString stringWithFormat:@"(%@)", sentence.translation];

            self.sentencesScrollView.contentSize = CGSizeMake(self.sentencesScrollView.contentSize.width + pageView.frame.size.width, self.sentencesScrollView.contentSize.height);
        }

    } else if (self.languoid.country.count > 0) {
        self.infoContainerSpace.constant = 2 * standardDistance + CGRectGetHeight(self.countryLabel.frame);
    } else {
        self.infoContainerSpace.constant = standardDistance;
    }

}

#pragma mark UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [valueArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *detailText = valueArray[indexPath.section][indexPath.row];

    CGSize boundingBox = [detailText boundingRectWithSize:CGSizeMake(tableView.frame.size.width - (standardDistance / 2), FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;

    CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height + (standardDistance / 2);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    NSString *labelString = titleArray[section];
    
    headerCell.sectionLabel.text = NSLocalizedString(labelString, nil);
    return headerCell.contentView;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"detailCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.detailLabel.text = valueArray[indexPath.section][indexPath.row];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, standardDistance)];
}

#pragma mark IBAction

- (IBAction)leftCountryButtonPressed:(id)sender {
    self.currentCountryIndex--;
    [self updateCountrySelection];
}

- (IBAction)rightCountryButtonPressed:(id)sender {
    self.currentCountryIndex++;
    [self updateCountrySelection];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"displayGlottoView"]) {
        GlottoViewController *destViewController =
                (GlottoViewController *) [segue destinationViewController];
        destViewController.glottoID = [self.languoid valueForKey:@"key"];
    }
}


@end
