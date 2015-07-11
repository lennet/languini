//
//  CountriesAggregator.h
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DataAggregator.h"
#import "Country.h"

@interface CountriesAggregator : DataAggregator

+ (Country *)getCountryForCode:(NSString *)code;

@end
