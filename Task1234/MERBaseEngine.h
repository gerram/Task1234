//
//  MERBaseEngine.h
//  Task1234
//
//  Created by George Malushkin on 23/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MERBaseEngine : NSObject

@property (nonatomic, assign, readonly) NSInteger scores;
//@property (nonatomic, strong, readonly) NSMutableArray *matchingList;// cumulated matching cards right now
@property (nonatomic, assign, readonly) NSInteger competitors; // amount of competitors, 0 => only you, -1 => against computer, 1.. - against people

- (void)addCardToMatchingList:(id)card;

@end
