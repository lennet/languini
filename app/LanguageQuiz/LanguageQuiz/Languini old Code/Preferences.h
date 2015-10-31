//
//  Preferences.h
//  Languini
//
//  Created by Leo Thomas on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

- (NSString *)getDefaultUserName;

- (void)setDefaultUserName:(NSString *)name;

@end
