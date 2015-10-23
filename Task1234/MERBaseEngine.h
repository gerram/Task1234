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
@property (nonatomic, assign) NSUInteger matchingAmount; // cumulate amount of matching card right now
@property (nonatomic, assign, readonly) NSInteger competitors; // amount of competitors, 0 => only you, -1 => against computer, 1.. - against people 
@end
