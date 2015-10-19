//
//  MERBaseCardV.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERBaseCardV.h"

static const CGFloat CORNER_RADIUS = 10.0;
static const CGFloat BASESIZE_HEIGHT = 133.0;
static const CGFloat BASESIZE_WIDTH = 100.0;



@implementation MERBaseCardV

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


#pragma mark - Drawing
- (CGFloat)cornerScaleFactor
{
    return self.bounds.size.height / BASESIZE_HEIGHT;
}

- (CGFloat)cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
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





@end
