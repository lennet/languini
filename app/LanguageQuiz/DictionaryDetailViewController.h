//
//  DictionaryDetailViewController.h
//  LanguageQuiz
//
//  Created by Daniel  on 20.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiHelper.h"


@interface DictionaryDetailViewController : UIViewController <WikiHelperDelegate> {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIWebView *websiteView;
}

@property (nonatomic, retain) NSString *searchString;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIWebView *websiteView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end
