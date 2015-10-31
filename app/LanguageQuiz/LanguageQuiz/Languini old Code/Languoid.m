//
//  Languoid.m
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "Languoid.h"
#import "Country.h"
#import "Sentence.h"
#import <objc/runtime.h>


@implementation Languoid

@dynamic alternateNames;
@dynamic classification;
@dynamic dialects;
@dynamic iso6393;
@dynamic key;
@dynamic lanugageStatus;
@dynamic locationDescription;
@dynamic macroareaGl;
@dynamic name;
@dynamic population;
@dynamic populationNumeric;
@dynamic sentence;
@dynamic country;


// http://hesh.am/2013/01/transform-properties-of-an-nsobject-into-an-nsdictionary/
- (NSDictionary *)getExistingProperties {
    unsigned int count = 0;
    // Get a list of all properties in the class.
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *value = [self valueForKey:key];
        
        // Only add to the NSDictionary if it's not nil.
        if (value)
        dictionary[key] = value;
    }
    
    free(properties);
    
    return dictionary;
}

+ (NSString *)entityName {
    return @"Languiod";
}
@end
