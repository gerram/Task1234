//
//  MERSetCard.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERSetCard.h"

static const CGFloat SHAPES_BOUNDS_PERCENTAGE = 0.75;

@implementation MERSetCard

#pragma mark - Properties
- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self drawShapes];
}

- (CGFloat)offseShapeVertical
{
    return (self.bounds.size.height - self.bounds.size.height * SHAPES_BOUNDS_PERCENTAGE) / 2;
}

- (CGFloat)offsetShapeHorizontal
{
    return (self.bounds.size.width - self.bounds.size.width * SHAPES_BOUNDS_PERCENTAGE) / 2;
}


/* Shapes */
- (void)drawShapes
{
    //TODO: To make generator for vertical shift
    int i = 1;
    while (i <= _rank) {
        switch (i) {
            case 1:
                [self pushContextCTMTranslateUp:0 andLeft:[self offsetShapeHorizontal]];
                
                if ([_shape isEqualToString:@"diamond"]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:@"twix"]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:@"wing"]) {
                    [self drawShapeWing];
                }
                
                [self popContext];
                break;
                
            case 2:
                [self pushContextCTMTranslateUp:60.0 andLeft:[self offsetShapeHorizontal]];
                
                if ([_shape isEqualToString:@"diamond"]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:@"twix"]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:@"wing"]) {
                    [self drawShapeWing];
                }
                
                [self popContext];
                break;
                
            case 3:
                [self pushContextCTMTranslateUp:120.0 andLeft:[self offsetShapeHorizontal]];
                
                if ([_shape isEqualToString:@"diamond"]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:@"twix"]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:@"wing"]) {
                    [self drawShapeWing];
                }
                
                [self popContext];
                break;
                
            default:
                break;
        }
        i++;
    }
}

- (void)drawShapeDiamond
{
    // Make 1/3 sizes box for shape
    CGRect shapeRect = CGRectMake(0, 0, self.bounds.size.width * SHAPES_BOUNDS_PERCENTAGE, self.bounds.size.height / 3 * SHAPES_BOUNDS_PERCENTAGE);
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.frame = shapeRect;
    shape.lineWidth = 2.0;
    shape.strokeColor = [UIColor greenColor].CGColor;
    shape.fillColor = [UIColor grayColor].CGColor;
    
    CGFloat width = shape.bounds.size.width;
    CGFloat height = shape.bounds.size.height;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, height / 2.0);
    CGPathAddLineToPoint(path, nil, width / 2.0, 0);
    CGPathAddLineToPoint(path, nil, width, height / 2.0);
    CGPathAddLineToPoint(path, nil, width / 2, height);
    CGPathCloseSubpath(path);

    shape.path = path;
    
    //[self.layer insertSublayer:shape atIndex:0];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [shape renderInContext:context];
    
    
    /* Through Context */
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGColorRef greenColor = [UIColor greenColor].CGColor;
    CGContextSetStrokeColorWithColor(context, greenColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height / 2);
    CGContextAddLineToPoint(context, self.bounds.size.width / 2, self.bounds.size.height / 2 - 40.0);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height / 2);
    CGContextAddLineToPoint(context, self.bounds.size.width / 2, self.bounds.size.height / 2 + 40.0);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    [self.layer renderInContext:context];
    */
}

- (void)drawShapeTwix
{
    
}

- (void)drawShapeWing
{
    
}

- (void)pushContextCTMTranslateUp:(CGFloat)shiftUp andLeft:(CGFloat)shiftLeft
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, shiftLeft, shiftUp);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

@end
