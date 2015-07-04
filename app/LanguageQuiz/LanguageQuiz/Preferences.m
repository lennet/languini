//
//  Preferences.m
//  Languini
//
//  Created by Leo Thomas on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "Preferences.h"

#define defaultUserNameKey @"defaultUserName"

@implementation Preferences

- (NSString *)getDefaultUserName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultUserNameKey];
}

- (void)setDefaultUserName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:defaultUserNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
