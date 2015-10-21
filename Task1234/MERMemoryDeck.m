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

    NSArray *suits = @[@"A", @"B", @"C", @"D"];
    NSArray *ranks = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", @"A"];
    NSMutableArray *fullArray = [[NSMutableArray alloc] init];
    
    for (NSString *suit in suits) {
        for (NSString *rank in ranks) {
            [fullArray addObject:[suit stringByAppendingString:rank]];
        }
    }
    
    return fullArray;
}

@end
