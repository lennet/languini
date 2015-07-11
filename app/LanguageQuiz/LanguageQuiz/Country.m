//
//  Country.m
//  Languini
//
//  Created by Leo Thomas on 11/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "Country.h"
#import "Languoid.h"


@implementation Country

@dynamic name;
@dynamic nameDe;
@dynamic code;
@dynamic latitude;
@dynamic longitude;
@dynamic languiod;

+ (NSString *)entityName{
    return @"Country";
}

@end
