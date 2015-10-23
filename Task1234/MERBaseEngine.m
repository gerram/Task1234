//
//  MERBaseEngine.m
//  Task1234
//
//  Created by George Malushkin on 23/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseEngine.h"

@interface MERBaseEngine ()
@property (nonatomic, assign) NSInteger scores;
@property (nonatomic, strong) NSMutableArray *matchingList;
@end

@implementation MERBaseEngine

#pragma mark - Properties
- (NSArray *)matchingList
{
    if (!_matchingList) {
        _matchingList = [[NSMutableArray alloc] init];
    }
    return _matchingList;
}


#pragma mark - Methods
- (void)addCardToMatchingList:(NSString *)card
{
    [self.matchingList addObject:card];
    [self matchingListProcessing];
}

// for overriding
- (void)matchingListProcessing
{
    //
}

@end
