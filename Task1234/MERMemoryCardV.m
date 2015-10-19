//
//  MERMemoryCardV.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryCardV.h"
#import "MERBaseCardV.h"

@interface MERBaseCardV ()
- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
@end


@implementation MERMemoryCardV

#pragma mark - Properties
- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (void)setFaceUP:(BOOL)faceUP
{
    _faceUP = faceUP;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.faceUP) {
        [self drawCorners];
        
    } else {
        //TODO: To make AspectFit mode for this image
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

- (CGFloat)cornerOffset
{
    return [super cornerRadius] / 3.0;
}

- (void)drawCorners
{
    // Size of font depends on corner, corner depens on rect...
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [super cornerScaleFactor]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSString *pip = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
    NSAttributedString *pipAttr = [[NSAttributedString alloc] initWithString:pip attributes:@{ NSFontAttributeName: cornerFont, NSParagraphStyleAttributeName: paragraphStyle}];
    
    CGRect pipBound;
    pipBound.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    pipBound.size = pipAttr.size;
    [pipAttr drawInRect:pipBound];
    
    [self pushContexCTMRotate180];
    [pipAttr drawInRect:pipBound];
    [self popContext];
}

- (void)pushContexCTMRotate180
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Gestures
// overriden
- (void)MERCardRespondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    self.faceUP = !self.faceUP;
}




@end
