//
//  MERSetDeck.m
//  Task1234
//
//  Created by George Malushkin on 20/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERSetDeck.h"

@implementation MERSetDeck

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
    // Generate strings: "AAA1", "AAA2", ... etc
    NSArray *suits = @[@"A", @"B", @"C"];
    NSArray *colors = @[@"A", @"B", @"C"];
    NSArray *fills = @[@"A", @"B", @"C"];
    NSArray *ranks = @[@1, @2, @3];
    NSMutableArray *fullArray = [@[] mutableCopy];
    
    for (NSString *suit in suits) {
        for (NSString *color in colors) {
            for (NSString *fill in fills) {
                for (NSNumber *rank in ranks) {
                    [fullArray addObject:[NSString stringWithFormat:@"%@%@%@%@", suit, color, fill, rank]];
                }
            }
        }
    }
    
    return fullArray;
}

@end
