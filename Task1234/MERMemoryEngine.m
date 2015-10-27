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
        [self.matchingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //
            MERMemoryCardV *cardLf = self.matchingList[idx];
            MERMemoryCardV *cardRt = self.matchingList[idx+1];
            
            MERMemoryCardV *cardLfScene = [self.tabledCards objectAtIndex:[self indexOfObject:cardLf]];
            MERMemoryCardV *cardRtScene = [self.tabledCards objectAtIndex:[self indexOfObject:cardRt]];
            
            if ([cardLf.suit isEqualToString:cardRt.suit]) {
                cardLfScene.isPlayed = TRUE;
                cardLfScene.faceUP = TRUE;
                cardRtScene.isPlayed = TRUE;
                cardRtScene.faceUP = TRUE;
                NSLog(@"!!! +1 score !!!");
            
            } else {
                cardLfScene.faceUP = FALSE;
                cardLfScene.isMatch = FALSE;
                cardRtScene.faceUP = FALSE;
                cardRtScene.isMatch = FALSE;
                NSLog(@"!!! -1 score !!!");
            }
            
            if (idx+2 == self.amountCardsForLevel) {
                *stop = TRUE;
            }
        
        }];
        
        self.matchingList = nil;
        
    } else {
        [self.matchingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MERMemoryCardV *cardScene = [self.tabledCards objectAtIndex:[self indexOfObject:obj]];
            cardScene.isMatch = TRUE;
            cardScene.faceUP = TRUE;
        }];
    }
}


- (NSUInteger)indexOfObject:(MERMemoryCardV *)cardObj
{
    /*
    Search index of current card object in tabledList
     */
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"(suit = %@)", cardObj.suit];
    NSPredicate *predB = [NSPredicate predicateWithFormat:@"(rank = %d)", cardObj.rank];
    NSCompoundPredicate *pred = [NSCompoundPredicate andPredicateWithSubpredicates:@[predA, predB]];
    NSArray *results = [self.tabledCards filteredArrayUsingPredicate:pred];
    
    return [self.tabledCards indexOfObject:results.firstObject];
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
