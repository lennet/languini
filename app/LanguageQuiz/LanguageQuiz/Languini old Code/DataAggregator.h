//
//  DataAggregator.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 25.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataAggregator : NSObject

- (id)readFile:(NSString *)fileName format:(NSString *)formatName;

- (NSString *)getPathForFileName:(NSString *)fileName formatName:(NSString *)formatName;

- (NSArray *)getObjectsForEntity:(NSString *)entity withSortDescriptor:(NSSortDescriptor *)sortDescriptor andPredicate:(NSPredicate *)predicate andFetchLimit:(NSInteger)limit;

- (NSUInteger)countObjectsForEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate;

- (NSManagedObjectContext *)context;

- (void)saveContext;

@end
