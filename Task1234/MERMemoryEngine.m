//
//  MERMemoryEngine.m
//  Task1234
//
//  Created by George Malushkin on 15/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryEngine.h"
#import "MERMemoryCardV.h"
#import "MERMemoryDeck.h"

@interface MERBaseEngine ()
@property (nonatomic, strong) NSMutableArray *matchingList;
@end

@interface MERMemoryEngine ()
@property (nonatomic, strong) NSArray *tabledCards;
@property (strong, nonatomic) MERMemoryDeck *deck;
@end

@implementation MERMemoryEngine

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Properties
- (NSUInteger)amountCardsForLevel
{
    if (!_amountCardsForLevel) {
        self.amountCardsForLevel = 2;
    }
    return _amountCardsForLevel;
}

- (MERMemoryDeck *)deck
{
    if (!_deck) {
        _deck = [[MERMemoryDeck alloc] init];
    }
    return _deck;
}

// overridden
- (void)matchingListProcessing
{
    if ([self.matchingList count] == self.amountCardsForLevel) {
        NSLog(@"WoW !!! Enough !!!");
        
        // 1. Check for "A?" isEqual "A?"
        [self.matchingList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            MERMemoryCardV *cardLf = self.matchingList[idx];
            MERMemoryCardV *cardRt = self.matchingList[idx+1];
            
            if ([cardLf.suit isEqualToString:cardRt.suit]) {
                cardLf.isPlayed = TRUE;
                cardRt.isPlayed = TRUE;
                NSLog(@"!!! +1 score !!!");
            }
            
            if (idx+2 == self.amountCardsForLevel) {
                *stop = TRUE;
            }
        
        }];
        
        
        self.matchingList = nil;
    }
}

#pragma mark - Public
- (void)addTabledCards:(NSArray *)cardVs
{
    for (MERMemoryCardV *card in cardVs) {
        if (![card isKindOfClass:[MERMemoryCardV class]]) {
            return;
        }
    }
    self.tabledCards = cardVs;
}

- (void)generateTabledCards:(NSUInteger)quantity
{
    NSMutableArray *a = [[NSMutableArray alloc] init];
    int i = 0;
    while (i < quantity) {
        [a addObject: [self.deck drawRandomCard]];
        i++;
    }
    self.tabledCards = a;
}


@end
