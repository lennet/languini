//
//  DictionaryDetailViewController.h
//  LanguageQuiz
//
//  Created by Daniel  on 20.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Languoid.h"
#import <MapKit/MapKit.h>
#import "DetailCell.h"


@interface DictionaryDetailViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, retain) Languoid *languoid;
@property(strong, nonatomic) IBOutlet MKMapView *mapView;
@property(strong, nonatomic) IBOutlet UILabel *countryLabel;

@property(strong, nonatomic) IBOutlet UIScrollView *sentencesScrollView;
@property(strong, nonatomic) IBOutlet NSLayoutConstraint *infoContainerSpace;
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet NSLayoutConstraint *infoContainerHeight;
@property(strong, nonatomic) NSArray *titleArray;
@property(strong, nonatomic) NSArray *valueArray;
@property(strong, nonatomic) IBOutlet UIButton *glottologButton;
@property(strong, nonatomic) IBOutlet UIButton *rightCountryButton;
@property(strong, nonatomic) IBOutlet UIButton *leftCountryButton;
@property(strong, nonatomic) IBOutlet UIView *offlineView;


@property(nonatomic) NSUInteger currentCountryIndex;

@end
