//
//  CountriesAggregator.m
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "CountriesAggregator.h"

@implementation CountriesAggregator

- (id)init {
    self = [super init];
    if (self) {
        if (![self dataBaseAlreadyFilled]) {
            [self aggregateCountries];
        }
    }
    return self;
}

- (void)aggregateCountries {
    NSDictionary *countriesDict = [self readFile:@"countries" format:@"json"];
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    for (NSDictionary *countryDict in countriesDict) {
        Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:[Country entityName] inManagedObjectContext:context];
        newCountry.name = countryDict[@"name"];
        newCountry.nameDe = countryDict[@"name-de"];
        newCountry.code = countryDict[@"iso-code"];
        newCountry.longitude = countryDict[@"long"];
        newCountry.latitude = countryDict[@"lat"];
    }
    
    [appdelegate saveContext];
}

- (BOOL)dataBaseAlreadyFilled {
    return [self countObjectsForEntity:[Country entityName] withPredicate:nil] > 0;
}

+ (Country *)getCountryForCode:(NSString *)code {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Country entityName]];
    
    NSError *error;
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSArray *result = [fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"code == %@", code]];
    return result.firstObject;
}

@end
