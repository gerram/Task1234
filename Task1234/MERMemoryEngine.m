//
//  MERMemoryEngine.m
//  Task1234
//
//  Created by George Malushkin on 15/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryEngine.h"
@interface MERBaseEngine ()
@property (nonatomic, strong) NSMutableArray *matchingList;
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

// overridden
- (void)matchingListProcessing
{
    if ([self.matchingList count] == self.amountCardsForLevel) {
        NSLog(@"WoW !!! Enough !!!");
        self.matchingList = nil;
    }
}

@end
