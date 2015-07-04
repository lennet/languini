//
//  HighScoreEntry.m
//  Languini
//
//  Created by Leo Thomas on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "HighScoreEntry.h"


@implementation HighScoreEntry

@dynamic name;
@dynamic score;
@dynamic quizType;

+ (NSString *)entityName{
    return @"HighScoreEntry";
}

@end
