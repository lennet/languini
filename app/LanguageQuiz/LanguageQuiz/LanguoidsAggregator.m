//
//  LanguoidsAggregator.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 26.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "LanguoidsAggregator.h"

#define magicalOffset 0

@implementation LanguiodsAggregator

- (id)init {
    self = [super init];
    if (self) {
        if (![self dataBaseAlreadyFilled]) {
            [self aggregateLanguiods];
        }
    }
    return self;
}

- (void)aggregateLanguiods {
    NSDictionary *languoidsDict = [self readFile:@"languoids3" format:@"json"];
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    for (id key in [languoidsDict allKeys]) {
        Languoid *newLanguiod = [NSEntityDescription insertNewObjectForEntityForName:@"Languiod" inManagedObjectContext:context];
        newLanguiod.key = key;

        NSDictionary *languoidDict = languoidsDict[key];
        newLanguiod.name = languoidDict[@"name"];
        newLanguiod.classification = languoidDict[@"classification-gl"];
        newLanguiod.population = languoidDict[@"population"];
        newLanguiod.macroareaGl = languoidDict[@"macroarea-gl"];
        newLanguiod.alternateNames = languoidDict[@"alternate_names"];
        newLanguiod.iso6393 = languoidDict[@"iso_639-3"];
        newLanguiod.countries = languoidDict[@"country"];
        NSDictionary *coordinates = languoidDict[@"coordinates"];
        newLanguiod.longitude = [coordinates[@"longitude"] floatValue];
        newLanguiod.latitude = [coordinates[@"latitude"] floatValue];
        newLanguiod.locationDescription = languoidDict[@"location"];
        newLanguiod.dialects = languoidDict[@"dialects"];
        newLanguiod.populationNumeric = languoidDict[@"population_numeric"];
        newLanguiod.lanugageStatus = languoidDict[@"language_status"];
    }

    [appdelegate saveContext];
}

- (BOOL)dataBaseAlreadyFilled {
    return [self countObjectsForEntity:[Languoid entityName] withPredicate:nil] > 0;
}

- (NSArray *)getLanguiodsData {
    return [self getObjectsForEntity:[Languoid entityName] withSortDescriptor:[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] andPredicate:nil andFetchLimit:-1];
}

+ (Languoid *)getLanguoidForCode:(NSString *)code {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Languoid entityName]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" key = %@", code];
    [fetchRequest setPredicate:predicate];

    NSError *error;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects.count > 0 ? fetchedObjects.firstObject : nil;
}

- (NSArray *)getLanguiodsForCountryCode:(NSString *)countryCode {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Languoid entityName]];

    NSError *error;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSArray *result = [fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ANY countries contains[c] %@", [NSString stringWithFormat:@"[%@]", countryCode]]];
    return result;
}

- (NSArray *)getRandomLangouidsWithOut:(Languoid *)languoid andCount:(NSUInteger)count {

    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" key != %@", languoid.key];

    NSInteger randomNumber = arc4random() % [self countObjectsForEntity:[Languoid entityName] withPredicate:predicate];
    NSUInteger offset = magicalOffset + randomNumber;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Languoid entityName]];


    [fetchRequest setPredicate:predicate];

    fetchRequest.fetchLimit = count;
    fetchRequest.fetchOffset = offset;

    NSError *error;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;
}

@end
