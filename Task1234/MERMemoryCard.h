//
//  MERMemoryCard.h
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseCard.h"

@interface MERMemoryCard : MERBaseCard

@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, assign) BOOL faceUP;
@property (nonatomic, strong) NSString *suit;



@end
