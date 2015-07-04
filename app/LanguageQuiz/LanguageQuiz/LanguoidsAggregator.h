//
//  LanguoidsAggregator.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 26.04.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAggregator.h"
#import "Languoid.h"

@interface LanguiodsAggregator : DataAggregator

- (NSArray *)getLanguiodsForCountryCode:(NSString *)countryCode;

- (NSArray *)getLanguiodsData;

+ (Languoid *)getLanguoidForCode:(NSString *)code;

- (NSArray *)getRandomLangouidsWithOut:(Languoid *)languoid andCount:(NSUInteger)count;

@end
