//
//  MERMemoryCardV.h
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseCardV.h"

@interface MERMemoryCardV : MERBaseCardV

@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, assign) BOOL faceUP;
@property (nonatomic, assign) BOOL isPlayed;
@property (nonatomic, strong) NSString *suit;


- (NSString *)rankAsString;

@end
