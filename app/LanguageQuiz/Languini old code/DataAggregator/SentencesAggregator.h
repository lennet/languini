//
//  SentencesAggregator.h
//  LanguageQuiz
//
//  Created by Leo Thomas on 10/06/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DataAggregator.h"
#import "Sentence.h"

@interface SentencesAggregator : DataAggregator

- (Sentence *)getRandomSentence;

@end
