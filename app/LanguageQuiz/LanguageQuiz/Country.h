//
//  Country.h
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Languoid;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nameDe;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet *languiod;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addLanguiodObject:(Languoid *)value;
- (void)removeLanguiodObject:(Languoid *)value;
- (void)addLanguiod:(NSSet *)values;
- (void)removeLanguiod:(NSSet *)values;

+ (NSString *)entityName;

@end
