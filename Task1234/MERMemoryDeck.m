//
//  MERMemoryDeck.m
//  Task1234
//
//  Created by George Malushkin on 20/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryDeck.h"

@implementation MERMemoryDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

// overriding
- (NSMutableArray *)arrayGenerator
{
    NSArray *suits = @[@"♥︎", @"♦︎", @"♣︎", @"♠︎"];
    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    NSMutableArray *fullArray = [@[] mutableCopy];
    
    for (NSString *suit in suits) {
        for (NSString *rank in ranks) {
            [fullArray addObject:[suit stringByAppendingString:rank]];
        }
    }
    
    return fullArray;
}

@end
