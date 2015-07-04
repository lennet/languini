//
//  SentencesAggregator.m
//  LanguageQuiz
//
//  Created by Leo Thomas on 10/06/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "SentencesAggregator.h"
#import "LanguoidsAggregator.h"

#define magicalOffset 0

@implementation SentencesAggregator

- (id)init {
    self = [super init];
    if (self && ![self dataBaseAlreadyFilled]) {
        [self aggregateSentences];
    }
    return self;
}

- (BOOL)dataBaseAlreadyFilled {
    return [self countObjectsForEntity:[Sentence entityName] withPredicate:nil] > 0;
}

- (void)aggregateSentences {
    NSDictionary *senctencesDict = [self readFile:@"sentences" format:@"json"];
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    for (NSString *glottoCode in [senctencesDict allKeys]) {
        Languoid *currentLanguoid = [LanguiodsAggregator getLanguoidForCode:glottoCode];
        if (currentLanguoid) {
            NSArray *sentences = senctencesDict[glottoCode];
            for (NSDictionary *sentenceDict in sentences) {
                Sentence *newSentence = [NSEntityDescription insertNewObjectForEntityForName:@"Sentence" inManagedObjectContext:context];
                newSentence.sentence = sentenceDict[@"sentence"];
                newSentence.translation = sentenceDict[@"translation"];
                [currentLanguoid addSentenceObject:newSentence];
            }
        } else {
            // find languages for sentences
        }
    }
    [appdelegate saveContext];
}

- (Sentence *)getRandomSentence {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sentence.@count != 0"];


    NSInteger randomNumber = arc4random() % [self countObjectsForEntity:[Languoid entityName] withPredicate:predicate];
    NSUInteger offset = magicalOffset + randomNumber;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Languoid entityName]];

    fetchRequest.fetchOffset = offset;
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = predicate;
    NSError *error;
    NSArray *fetchResults = [context executeFetchRequest:fetchRequest error:&error];
    Languoid *languoid = fetchResults.count > 0 ? fetchResults.firstObject : nil;
    if (languoid) {
        NSArray *allSentences = ((NSSet *) languoid.sentence).allObjects;
        return allSentences.firstObject;
    }
    return nil;
}
@end
