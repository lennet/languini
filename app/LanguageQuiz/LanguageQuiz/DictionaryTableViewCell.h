//
//  LexiconTableViewCell.h
//  LanguageQuiz
//
//  Created by Daniel  on 29.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DictionaryTableViewCell : UITableViewCell
@property(strong, nonatomic) IBOutlet UILabel *mainLabel;
@property(strong, nonatomic) IBOutlet UILabel *detailLabel;

@end
