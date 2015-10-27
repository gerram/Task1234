//
//  MERMemoryCardV.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryCardV.h"
#import "MERBaseCardV.h"



static const CGFloat FACES_BOUNDS_PERCENTAGE = 0.65;


@interface MERBaseCardV ()
- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (void)MERCardRespondToTapGesture:(UITapGestureRecognizer *)recognizer;
@end


@interface MERMemoryCardV ()
@property (nonatomic, strong) NSDictionary *suitsDict;
@end

@implementation MERMemoryCardV

#pragma mark - Properties
- (NSDictionary *)suitsDict
{
    if (!_suitsDict) {
        _suitsDict = @{@"A": @"♥︎", @"B": @"♦︎", @"C": @"♣︎", @"D": @"♠︎"};
    }
    return _suitsDict;
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A"][self.rank];
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


- (void)setIsPlayed:(BOOL)isPlayed
{
    _isPlayed = isPlayed;
    if (_isPlayed) {
        self.faceUP = TRUE;
    }
    [self setNeedsDisplay];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.faceUP) {
        
        [self drawFaceOrPips];
        [self drawCorners];
        
    } else {
        //TODO: To make AspectFit mode for this image
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}


- (CGFloat)offseFaceVertical
{
    return (self.bounds.size.height - self.bounds.size.height * FACES_BOUNDS_PERCENTAGE) / 2;
}


- (CGFloat)offsetFaceHorizontal
{
    return (self.bounds.size.width - self.bounds.size.width * FACES_BOUNDS_PERCENTAGE) / 2;
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
    
    //NSString *cornerLabel = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suitsDict[self.suit]];
    NSString *cornerLabel = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suitsDict[self.suit]];
    UIColor *cornerColor = (([_suit isEqualToString:@"A"]) || ([_suit isEqualToString:@"B"])) ? [UIColor redColor] : [UIColor blackColor];
    NSAttributedString *cornerLabelAttr = [[NSAttributedString alloc] initWithString:cornerLabel attributes:@{ NSFontAttributeName: cornerFont, NSForegroundColorAttributeName: cornerColor, NSParagraphStyleAttributeName: paragraphStyle}];
    
    CGRect cornerLabelBound;
    cornerLabelBound.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    cornerLabelBound.size = cornerLabelAttr.size;
    [cornerLabelAttr drawInRect:cornerLabelBound];
    
    [self pushContexCTMRotate180];
    [cornerLabelAttr drawInRect:cornerLabelBound];
    [self popContext];
}

- (void)drawFaceOrPips
{
    if ((_rank >= 9) && (_rank < 12)) {
        UIOffset offset = UIOffsetMake([self offsetFaceHorizontal], [self offseFaceVertical]);
        CGRect faceRect = CGRectMake(offset.horizontal, offset.vertical, self.bounds.size.width * FACES_BOUNDS_PERCENTAGE, self.bounds.size.height * FACES_BOUNDS_PERCENTAGE);
        
        NSString *faceName = [NSString stringWithFormat:@"%@%@", self.suit, [self rankAsString]];
        UIImage *faceImage = [UIImage imageNamed: faceName];
        if (faceImage) {
            [faceImage drawInRect:faceRect];
        }
    } else if (_rank == 12) {
        // Size of font depends on corner, corner depens on rect...
        UIFont *faceFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        faceFont = [faceFont fontWithSize:self.bounds.size.height / 3];
        
        UIColor *faceColor = (([_suit isEqualToString:@"A"]) || ([_suit isEqualToString:@"B"])) ? [UIColor redColor] : [UIColor blackColor];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSAttributedString *faceLabelAttr = [[NSAttributedString alloc] initWithString:self.suitsDict[self.suit] attributes:@{ NSFontAttributeName: faceFont, NSForegroundColorAttributeName: faceColor, NSParagraphStyleAttributeName: paragraphStyle}];
        
        CGRect faceLabelBound;
        faceLabelBound.size = CGSizeMake(self.bounds.size.width, faceLabelAttr.size.height);
        faceLabelBound.origin = CGPointMake(0, (self.bounds.size.height - faceFont.pointSize) / 2.0);
        [faceLabelAttr drawInRect:faceLabelBound];
   
    } else {
        // draw pips
    }
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
    //self.faceUP = !self.faceUP;
    //if (!self.isMatch && !self.isPlayed) {
    if (!self.isMatch && !self.isPlayed) {
        self.isMatch = TRUE;
        self.faceUP = TRUE;
        [super MERCardRespondToTapGesture:recognizer];
    }
}




@end
