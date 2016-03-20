//
//  ResultTableViewCell.h
//  Languini
//
//  Created by Daniel  on 11.07.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *rankingLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;

@end
