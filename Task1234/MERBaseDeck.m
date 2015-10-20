//
//  MERBaseDeck.m
//  Task1234
//
//  Created by George Malushkin on 19/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseDeck.h"

@interface MERBaseDeck ()
@property (atomic, strong) NSMutableArray *baseDeck;
@end

@implementation MERBaseDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseDeck = [self arrayGenerator];
    }
    return self;
}

// for overriding
- (NSMutableArray *)arrayGenerator
{
    return nil;
}


- (NSString *)drawRandomCard
{
    if ([_baseDeck count] > 0) {
        NSString *card = [_baseDeck objectAtIndex:arc4random() % [_baseDeck count]];
        [self.baseDeck removeObject:card];
        
        return card;
        
    } else {
#pragma TODO: Deck is empty
        
        return nil;
    }
}






@end
