//
//  DictionaryViewControllerTableViewController.h
//  LanguageQuiz
//
//  Created by Daniel  on 27.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryTableViewCell.h"
#import "DictionaryDetailViewController.h"
#import "LanguoidsAggregator.h"


@interface DictionaryViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>
@property(nonatomic, retain) NSArray *sectionBar;
@property(nonatomic, retain) NSArray *specialDataSource;

@end
