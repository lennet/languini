//
//  StartViewController.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 25.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface StartViewController : UIViewController <MKMapViewDelegate>
@property(strong, nonatomic) IBOutlet MKMapView *mapView;

@end
