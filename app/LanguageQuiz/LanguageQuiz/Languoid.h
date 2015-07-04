//
//  Languoid.h
//  
//
//  Created by Leo Thomas on 10/06/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Sentence;

@interface Languoid : NSManagedObject


@property(nonatomic, retain) NSArray *alternateNames;
@property(nonatomic, retain) NSArray *classification;
@property(nonatomic, retain) NSArray *countries;
@property(nonatomic, retain) NSArray *dialects;
@property(nonatomic, retain) NSString *iso6393;
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) NSString *lanugageStatus;
@property(nonatomic) float latitude;
@property(nonatomic, retain) NSString *locationDescription;
@property(nonatomic) float longitude;
@property(nonatomic, retain) NSString *macroareaGl;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *population;
@property(nonatomic, retain) NSNumber *populationNumeric;
@property(nonatomic, retain) NSSet *sentence;
@end

@interface Languoid (CoreDataGeneratedAccessors)

- (void)addSentenceObject:(Sentence *)value;

- (void)removeSentenceObject:(Sentence *)value;

- (void)addSentence:(NSSet *)values;

- (void)removeSentence:(NSSet *)values;

- (NSDictionary *)getExistingProperties;

+ (NSString *)entityName;
@end
