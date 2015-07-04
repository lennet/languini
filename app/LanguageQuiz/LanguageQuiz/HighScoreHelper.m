//
//  HighScoreHelper.m
//  Languini
//
//  Created by Leo Thomas on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "HighScoreHelper.h"
#import "HighScoreEntry.h"

@implementation HighScoreHelper

- (void)addScore:(NSInteger)score WithName:(NSString *)name forType:(QuizType)type {
    NSManagedObjectContext *context = [self context];
    HighScoreEntry *newEntry = [NSEntityDescription insertNewObjectForEntityForName:[HighScoreEntry entityName] inManagedObjectContext:context];
    NSNumber *typeNumber = @(type);
    NSLog(@"%@", typeNumber);
    newEntry.score = @(score);
    newEntry.quizType = @(type);
    newEntry.name = name;
    [self saveContext];
}

- (NSArray *)getTopScoreEntriesForType:(QuizType)type {

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    NSNumber *typeNumber = @(type);
    NSLog(@"%@", typeNumber);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"quizType == %i", type];

    return [self getObjectsForEntity:[HighScoreEntry entityName] withSortDescriptor:sortDescriptor andPredicate:predicate andFetchLimit:10];
}

@end
