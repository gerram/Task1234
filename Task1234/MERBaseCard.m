//
//  MERBaseCard.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseCard.h"

@implementation MERBaseCard

- (CGFloat)cornerRadius
{
    //TODO: make automatic for defining these params
    CGFloat defaultRadius = 10.0;
    CGFloat scaleFactor = 1.0;
    
    return defaultRadius * scaleFactor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

#pragma mark - Init
- (void)awakeFromNib
{
    [self setupMe];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setupMe];
    
    return self;
}

- (void)setupMe
{
    self.backgroundColor = nil;
    self.opaque = FALSE;
    self.contentMode = UIViewContentModeRedraw;
}

@end
