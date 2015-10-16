//
//  MERSetCard.h
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseCard.h"

@interface MERSetCard : MERBaseCard

@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSString *fill;
@property (nonatomic, assign) NSUInteger rank;

@end
