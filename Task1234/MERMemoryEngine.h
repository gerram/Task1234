//
//  MERMemoryEngine.h
//  Task1234
//
//  Created by George Malushkin on 15/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseEngine.h"


@interface MERMemoryEngine : MERBaseEngine
@property (nonatomic, readonly) NSArray *tabledCards;
@property (nonatomic, assign) NSUInteger amountCardsForLevel;

- (void) addTabledCards:(NSArray *)cardVs;
- (void) generateTabledCards:(NSUInteger)quantity;
@end
