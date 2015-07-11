//
//  Languoid.h
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Sentence;

@interface Languoid : NSManagedObject

@property (nonatomic, retain) id alternateNames;
@property (nonatomic, retain) id classification;
@property (nonatomic, retain) id dialects;
@property (nonatomic, retain) NSString * iso6393;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * lanugageStatus;
@property (nonatomic, retain) NSString * locationDescription;
@property (nonatomic, retain) NSString * macroareaGl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * population;
@property (nonatomic, retain) NSNumber * populationNumeric;
@property (nonatomic, retain) NSSet *sentence;
@property (nonatomic, retain) NSSet *country;
@end

@interface Languoid (CoreDataGeneratedAccessors)

- (void)addSentenceObject:(Sentence *)value;
- (void)removeSentenceObject:(Sentence *)value;
- (void)addSentence:(NSSet *)values;
- (void)removeSentence:(NSSet *)values;

- (void)addCountryObject:(Country *)value;
- (void)removeCountryObject:(Country *)value;
- (void)addCountry:(NSSet *)values;
- (void)removeCountry:(NSSet *)values;

+ (NSString *)entityName;

@end
