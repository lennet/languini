//
//  Sentence.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 10/06/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Languoid.h"

@class Languoid;

@interface Sentence : NSManagedObject

@property(nonatomic, retain) NSString *sentence;
@property(nonatomic, retain) NSString *translation;
@property(nonatomic, retain) Languoid *languoid;

+ (NSString *)entityName;
@end
