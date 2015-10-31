//
//  DataAggregator.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 25.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DataAggregator.h"

@implementation DataAggregator

- (id)readFile:(NSString *)fileName format:(NSString *)formatName {
    NSError *error;
    NSData *resultData = [NSData dataWithContentsOfFile:[self getPathForFileName:fileName formatName:formatName]];
    id object = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    return object;
}

- (NSString *)getPathForFileName:(NSString *)fileName formatName:(NSString *)formatName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];

    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, formatName]];

    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSString *newPath = [[NSBundle mainBundle] pathForResource:fileName ofType:formatName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager copyItemAtPath:newPath toPath:path error:NULL];
    }
    return path;
}

- (NSUInteger)countObjectsForEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [self context];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];

    if (predicate) {
        fetchRequest.predicate = predicate;
    }

    NSError *error;

    return [context countForFetchRequest:fetchRequest error:&error];
}

- (NSArray *)getObjectsForEntity:(NSString *)entity withSortDescriptor:(NSSortDescriptor *)sortDescriptor andPredicate:(NSPredicate *)predicate andFetchLimit:(NSInteger)limit {
    NSManagedObjectContext *context = [self context];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];

    if (predicate) {
        fetchRequest.predicate = predicate;
    }

    if (sortDescriptor) {
        fetchRequest.sortDescriptors = @[sortDescriptor];
    }

    if (limit && limit > 0) {
        fetchRequest.fetchLimit = limit;
    }

    NSError *error;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

- (NSManagedObjectContext *)context {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    return context;
}

- (void)saveContext {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [appdelegate saveContext];
}

@end
