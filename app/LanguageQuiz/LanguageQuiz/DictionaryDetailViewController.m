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
    [self initObjectData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    
    self.title = self.languoid.name;

    [self.glottologButton setTitle:[NSString stringWithFormat:@"Glottlog - %@", [self.languoid valueForKey:@"key"]] forState:UIControlStateNormal];

    [self setUpTableView];
    [self setUpSentenceScrollView];
    [self setUpCountrySelection];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        [self.offlineView setHidden:false];
        [self.rightCountryButton setHidden:true];
        [self.leftCountryButton setHidden:true];
        [self.glottologButton setHidden:true];
    } else {
        [self.offlineView setHidden:true];
        [self.rightCountryButton setHidden:false];
        [self.leftCountryButton setHidden:false];
        [self.glottologButton setHidden:false];
    }
}

- (void)initObjectData {
    _objectData = [NSMutableDictionary new];
    self.languoid.name != nil ? _objectData[@"Name"] = self.languoid.name : nil;
    self.languoid.alternateNames != nil ? _objectData[@"Alternate Names"] = self.languoid.alternateNames : nil;
    self.languoid.classification != nil ? _objectData[@"Classification"] = self.languoid.classification : nil;
    self.languoid.country != nil ? _objectData[@"Countries"] = self.languoid.country : nil;
    self.languoid.dialects != nil ? _objectData[@"Dialects"] = self.languoid.dialects : nil;
    self.languoid.iso6393 != nil ? _objectData[@"ISO 6393 Code"] = self.languoid.iso6393 : nil;
    self.languoid.lanugageStatus != nil ? _objectData[@"Language Status"] = self.languoid.lanugageStatus : nil;
    self.languoid.locationDescription != nil ? _objectData[@"Location Description"] = self.languoid.locationDescription : nil;
    self.languoid.population != nil ? _objectData[@"Population"] = self.languoid.population : nil;

    [self setUpDataSource:_objectData];

}

- (void)setUpDataSource:(NSDictionary *)data {
    NSMutableArray *tmpTitle = [NSMutableArray new];
    NSMutableArray *tmpValues = [NSMutableArray new];
    if (data[@"Name"] != nil) {
        [tmpTitle addObject:@"Name"];
        [tmpValues addObject:data[@"Name"]];

    }
    if (data[@"Alternate Names"] != nil) {
        [tmpTitle addObject:@"Alternate Names"];
        [tmpValues addObject:data[@"Alternate Names"]];
    }

    if (data[@"Countries"] != nil) { // countries
        [tmpTitle addObject:@"Countries"];
        [tmpValues addObject:data[@"Countries"]];
    }
    if (data[@"Dialects"] != nil) { // dialects
        [tmpTitle addObject:@"Dialects"];
        [tmpValues addObject:data[@"Dialects"]];
    }
    if (data[@"Language Status"] != nil) { // Language status
        [tmpTitle addObject:@"Language Status"];
        [tmpValues addObject:data[@"Language Status"]];
    }
    if (data[@"Population"] != nil) { // population
        [tmpTitle addObject:@"Population"];
        [tmpValues addObject:data[@"Population"]];
    }
    if (data[@"Location Description"] != nil) { //location
        [tmpTitle addObject:@"Location Description"];
        [tmpValues addObject:data[@"Location Description"]];
    }
    if (data[@"ISO 6393 Code"] != nil) { // iso
        [tmpTitle addObject:@"ISO 6393 Code"];
        [tmpValues addObject:data[@"ISO 6393 Code"]];
    }
    if (data[@"Classification"] != nil) {
        [tmpTitle addObject:@"Classification"];
        [tmpValues addObject:data[@"Classification"]];
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
    self.rightCountryButton.hidden = self.currentCountryIndex == self.languoid.country.count - 1;
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
            pageView.frame = CGRectMake(self.sentencesScrollView.contentSize.width, 0, self.sentencesScrollView.frame.size.width, self.sentencesScrollView.frame.size.height);
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

    if ([valueArray[section] isKindOfClass:[NSArray class]]|| [valueArray[section] isKindOfClass:[NSSet class]]) {
        return [valueArray[section] count];
    } else {
        return 1;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *detailText = [self getDetailStringForIndex:indexPath];

    CGSize boundingBox = [detailText boundingRectWithSize:CGSizeMake(tableView.frame.size.width - (standardDistance / 2), FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;

    CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height + (standardDistance / 2);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    NSString *labelString = titleArray[section];
    
    headerCell.sectionLabel.text = labelString;
    return headerCell.contentView;

}

- (NSString *)getDetailStringForIndex:(NSIndexPath *)indexPath {
    if ([valueArray[indexPath.section] isKindOfClass:[NSArray class]]) {
        NSArray *valueObject = [valueArray[indexPath.section] allObjects];
        NSString *valueString = valueObject[indexPath.row];
        return valueString;
    }
    
    if ([valueArray[indexPath.section] isKindOfClass:[NSSet class]]) {
        NSArray *valueObject = [valueArray[indexPath.section] allObjects];
        id object = valueObject[indexPath.row];
        if ([object isKindOfClass:[Country class]]){
            Country *country = object;
            if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"de"] && country.nameDe) {
                return country.nameDe;
            } else {
                return country.name;
            }
        }
        NSString *valueString = object;
        return valueString;
    }
    if ([valueArray[indexPath.section] isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",
                                          valueArray[indexPath.section]];
    }
    if ([valueArray[indexPath.section] isKindOfClass:[NSDictionary class]]) {
        NSLog(@"NSDict");
    }
    return (NSString *) valueArray[indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"detailCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.detailLabel.text = [self getDetailStringForIndex:indexPath];

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
