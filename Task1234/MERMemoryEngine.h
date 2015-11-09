//
//  MERMemoryEngine.h
//  Task1234
//
//  Created by George Malushkin on 15/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseEngine.h"


typedef NS_ENUM(NSUInteger, GameMode) {
    GameModeEasy,
    GameModeNormal,
};

@interface MERMemoryEngine : MERBaseEngine

@property (nonatomic, readonly) NSArray *tabledCards;
@property (nonatomic, assign) GameMode gameMode;
@property (nonatomic, assign, readonly) NSUInteger matchingListCounter;

- (void) addTabledCards:(NSArray *)cardVs;
- (void) generateTabledCards:(NSUInteger)quantity;

@end
