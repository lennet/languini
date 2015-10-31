//
//  HighScoreHelper.h
//  Languini
//
//  Created by Leo Thomas on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuizControlViewController.h"
#import "DataAggregator.h"

@interface HighScoreHelper : DataAggregator


- (void)addScore:(NSInteger)score WithName:(NSString *)name forType:(QuizType)type;

- (NSArray *)getTopScoreEntriesForType:(QuizType)type;

-(NSUInteger)getLatestScoreIndexForType:(QuizType)type;

@end
