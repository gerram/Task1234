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
@property (nonatomic, strong, readwrite) NSMutableArray *matchingList;
@property (nonatomic, assign) NSInteger scores;
@end

@interface MERMemoryEngine ()
@property (nonatomic, strong) NSArray *tabledCards;
@property (strong, nonatomic) MERMemoryDeck *deck;
@property (nonatomic, assign) NSUInteger amountCardsForLevel;
@end

@implementation MERMemoryEngine
@synthesize scores;
@synthesize gameMode = _gameMode;

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
        if (self.gameMode == GameModeEasy) {
            _amountCardsForLevel = 3;
        } else if (self.gameMode == GameModeNormal) {
            _amountCardsForLevel = 2;
        }
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

- (GameMode)gameMode
{
    if (!_gameMode) {
        _gameMode = GameModeNormal;
        //_gameMode = GameModeEasy;
    }
    return _gameMode;
}

- (void)setGameMode:(GameMode)gameMode
{
    if (self.gameMode != gameMode) {
        _gameMode = gameMode;
        
        if (_gameMode == GameModeEasy) {
            self.amountCardsForLevel = 3;
        } else if (_gameMode == GameModeNormal) {
            self.amountCardsForLevel = 2;
        }
    }

    return;
}

- (NSUInteger)matchingListCounter
{
    return [self.matchingList count];
}

//- (void)setScores:(NSInteger)scores
//{
//    self.scores = scores;
//}


// overridden
- (void)matchingListProcessing
{
    if ([self.matchingList count] == self.amountCardsForLevel ) {
        NSLog(@"WoW !!! Enough !!!");
        
        typedef int (^PairScore)(MERMemoryCardV *lft, MERMemoryCardV *rht);
        PairScore pairScore = ^int (MERMemoryCardV *lft, MERMemoryCardV *rht) {
            int scoresI = 0;
            if ([lft.suit isEqualToString:rht.suit]) {
                // 1. Check for "A?" isEqual "A?"
                scoresI++;
            } else if (lft.rank == rht.rank) {
                // 2. Check for "?9" isEqual "?9"
                scoresI = scoresI + 4;
            } else {
                scoresI--;
            }
            
            return scoresI;
        };
        
        __block NSMutableDictionary *scoresRange = [[NSMutableDictionary alloc] init];
        [self.matchingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if (self.gameMode == GameModeNormal) {
                int scoresI = pairScore(obj, self.matchingList[idx+1]);
                
                // Using dict of sets as keys for finding max score in range of possible scores,
                // generally for easy mode, when you can choose 3 card
                NSArray *pair = [NSArray arrayWithObjects:obj, self.matchingList[idx+1], nil];
                scoresRange[pair] = [NSNumber numberWithInt:scoresI];
                
            } else if (self.gameMode == GameModeEasy) {
                int scoresI = pairScore(obj, self.matchingList[idx+1]);
                NSArray *pair = [NSArray arrayWithObjects:obj, self.matchingList[idx+1], nil];
                scoresRange[pair] = [NSNumber numberWithInt:scoresI];
                
                if (idx+2 < self.amountCardsForLevel) {
                    int scoresI = pairScore(obj, self.matchingList[idx+2]);
                    NSArray *pair = [NSArray arrayWithObjects:obj, self.matchingList[idx+2], nil];
                    scoresRange[pair] = [NSNumber numberWithInt:scoresI];
                }
            }
            
            // Stop for last item
            if (idx + 2 == self.amountCardsForLevel) {
                *stop = TRUE;
            }
        
        }];
        
        __block NSArray *result;
        [scoresRange enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                if ([(NSNumber *)obj intValue]  >= 1) {
                    result = key;
                } else if ([(NSNumber *)obj intValue] == 4) {
                    result = key;
                    *stop = TRUE;
                }
            }
        }];
        
        
        if (!result) {
            [self.matchingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MERMemoryCardV *cardScene = [self.tabledCards objectAtIndex:[self indexOfObject:obj]];
                cardScene.faceUP = FALSE;
                cardScene.isMatch = FALSE;
                cardScene.faceUP = FALSE;
                cardScene.isMatch = FALSE;
            }];
            
            self.scores--;
            
        } else {
            MERMemoryCardV *cardAScene = [self.tabledCards objectAtIndex:[self indexOfObject:result[0]]];
            MERMemoryCardV *cardBScene = [self.tabledCards objectAtIndex:[self indexOfObject:result[1]]];
            cardAScene.isPlayed = TRUE;
            cardAScene.faceUP = TRUE;
            cardAScene.isMatch = FALSE;
            cardBScene.isPlayed = TRUE;
            cardBScene.faceUP = TRUE;
            cardBScene.isMatch = FALSE;
            
            // Third card in matchingList
            [self.matchingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (([obj rank] != cardAScene.rank && ![[obj suit] isEqualToString:cardAScene.suit]) &&
                    ([obj rank] != cardBScene.rank && ![[obj suit] isEqualToString:cardBScene.suit])
                    ) {
                    MERMemoryCardV *cardCScene = [self.tabledCards objectAtIndex:[self indexOfObject:obj]];
                    cardCScene.faceUP = FALSE;
                    cardCScene.isMatch = FALSE;
                    *stop = TRUE;
                }
            }];
            
            self.scores = self.scores + [(NSNumber *)scoresRange[result] intValue];
        }
    
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
