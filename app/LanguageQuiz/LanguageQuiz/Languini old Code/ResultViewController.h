//
//  ResultViewController.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 10.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizControlViewController.h"

@interface ResultViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic) QuizType type;
@property(nonatomic) NSInteger newScore;

@end
