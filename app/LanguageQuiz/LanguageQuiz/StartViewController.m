//
//  StartViewController.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 25.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "StartViewController.h"
#import "DictionaryViewController.h"
#import "QuizControlViewController.h"
#import "ResultViewController.h"

#define questionDelay 4
BOOL annotationSet;
BOOL loadSpecialDict;
NSArray *countriesOnLocation;

@interface StartViewController () <QuizControlViewControllerDelegate>

@property(strong, nonatomic) LanguiodsAggregator *langAggregator;
@property(strong, nonatomic) IBOutlet UIButton *geoQuizButton;
@property(strong, nonatomic) IBOutlet UIButton *dictionaryButton;
@property(strong, nonatomic) IBOutlet UIButton *aboutButton;
@property(strong, nonatomic) IBOutlet UIButton *quizButton;
@property(strong, nonatomic) IBOutlet UIView *gameControllerContainer;
@property(strong, nonatomic) IBOutlet UIView *questionView;
@property(strong, nonatomic) QuizControlViewController *quizController;
@property(nonatomic) BOOL quizMode;
@property(nonatomic) BOOL shouldHandleTouches;
@property(strong, nonatomic) IBOutlet UILabel *questionLabel;

@property(nonatomic) MKGeodesicPolyline *distanceLine;


@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.langAggregator = [LanguiodsAggregator new];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    loadSpecialDict = false;
}

- (void)setUpMapView {
//    [self.mapView setzo]
}

- (IBAction)handleGeoQuizButtonPressed:(id)sender {
    [self.mapView removeAnnotation:[self.mapView.annotations lastObject]];
    annotationSet = false;
    [self.quizController resetScores];
    self.quizMode = YES;
    self.shouldHandleTouches = YES;
    [self.quizController nextQuestion];
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:kNilOptions animations:^{
        self.geoQuizButton.alpha = 0;
        self.quizButton.alpha = 0;
        self.aboutButton.alpha = 0;
        self.dictionaryButton.alpha = 0;
        self.gameControllerContainer.alpha = 1;
        self.questionView.alpha = 1;
    }                completion:^(BOOL finished) {
//        self.geoQuizButton.enabled = NO;
//        self.quizButton.enabled = NO;
//        self.aboutButton.enabled = NO;
//        self.dictionaryButton.enabled = NO;

    }];

}

#pragma mark MKMapViewDelegate

- (IBAction)didTappedOnMap:(UIGestureRecognizer *)sender {
    if (self.shouldHandleTouches || !self.quizMode) {
        self.shouldHandleTouches = NO;
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLGeocoder *geoCoder = [CLGeocoder new];
        CLLocationCoordinate2D touchCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:touchCoordinate.latitude longitude:touchCoordinate.longitude];

        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark = placemarks.firstObject;

            CLLocation *correctLocation = [self.quizController getCorrectLocation];
            CLLocationDistance distance = [location distanceFromLocation:correctLocation];

            if (placemark.ISOcountryCode != nil && [self.quizController isValidAnswer:placemark.ISOcountryCode distance:distance]) {
                NSLog(@"richtig");
                [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:questionDelay];
            } else if (self.quizMode) {
                CLLocationCoordinate2D locations[2];
                locations[0] = touchCoordinate;
                locations[1] = correctLocation.coordinate;

                self.distanceLine = [MKGeodesicPolyline polylineWithCoordinates:(CLLocationCoordinate2D *) locations count:2];

                [self.mapView setVisibleMapRect:[self.distanceLine boundingMapRect] edgePadding:UIEdgeInsetsMake(CGRectGetMaxX(self.questionView.frame) + CGRectGetMinY(self.questionView.frame) + 10, 15.0, CGRectGetHeight(self.gameControllerContainer.frame) + 10, 15.0) animated:YES];

                [self.mapView addOverlay:self.distanceLine];

                [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:questionDelay];
            }
            else {
                
                countriesOnLocation = [self.langAggregator getLanguiodsForCountryCode:placemark.ISOcountryCode];
                [self addAnnotationOnLocation:touchCoordinate];
                
            }

        }];
    }
}

- (void)addAnnotationOnLocation:(CLLocationCoordinate2D)touchCoordinate {
    if (annotationSet == true) {
        [self.mapView removeAnnotation:[self.mapView.annotations lastObject]];
        annotationSet = false;
    }
    MKPointAnnotation *languageAnnotation = [[MKPointAnnotation alloc] init];
    languageAnnotation.coordinate = touchCoordinate;
    languageAnnotation.title = [NSString stringWithFormat:@"%lu Sprachen", (unsigned long) countriesOnLocation.count];
    languageAnnotation.subtitle = @"";
    annotationSet = true;
    [self.mapView addAnnotation:languageAnnotation];
    NSLog(@"Added %@", languageAnnotation.title);
  //  [self.mapView showAnnotations:[self.mapView.annotations objectAtIndex:0] animated:YES];
    

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    if (!annotationView) {
        NSLog(@"no annotationView");
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    

    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;

    return annotationView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    if (overlay == self.distanceLine) {

        MKPolylineView *lineView = [[MKPolylineView alloc] initWithPolyline:self.distanceLine];
        lineView.fillColor = [UIColor redColor];
        lineView.strokeColor = [UIColor redColor];
        lineView.lineWidth = 5;

        return lineView;
    }

    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        NSLog(@"Clicked accessoryControl");
    }
    loadSpecialDict = true;
    [self performSegueWithIdentifier:@"loadDictionaryViewController" sender:self];
}

#pragma mark QuizControlViewControllerDelegate

- (void)shouldUpdateQuestionLabel:(NSString *)question {
    self.questionLabel.text = question;
}

- (void)shouldFinishGame {
    [self performSegueWithIdentifier:@"gameResultSegue" sender:nil];
}

- (void)didPressedExitButton {
    if (self.distanceLine) {
        [self.mapView removeOverlay:self.distanceLine];
        self.distanceLine = nil;
    }
    self.shouldHandleTouches = NO;
    self.quizMode = false;
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:kNilOptions animations:^{
        self.geoQuizButton.alpha = 1;
        self.quizButton.alpha = 1;
        self.aboutButton.alpha = 1;
        self.dictionaryButton.alpha = 1;
        self.gameControllerContainer.alpha = 0;
        self.questionView.alpha = 0;
    }                completion:^(BOOL finished) {
    }];
}

- (void)nextQuestion {
    if (self.distanceLine) {
        [self.mapView removeOverlay:self.distanceLine];
        self.distanceLine = nil;
    }
    [self.quizController nextQuestion];
    self.shouldHandleTouches = YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DictionaryViewController class]]) {
        [self.navigationController setNavigationBarHidden:false animated:true];
        if (loadSpecialDict == true) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            [segue.destinationViewController setSpecialDataSource:[countriesOnLocation sortedArrayUsingDescriptors:@[sort]]];
            loadSpecialDict = false;
        }
    } else if ([segue.destinationViewController isKindOfClass:[QuizControlViewController class]]) {
        self.quizController = segue.destinationViewController;
        self.quizController.type = GeoQuiz;
        self.quizController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[ResultViewController class]]) {
        ResultViewController *resultViewController = [segue destinationViewController];
        resultViewController.type = self.quizController.type;
        resultViewController.newScore = [self.quizController getScore];
    }
}


@end
