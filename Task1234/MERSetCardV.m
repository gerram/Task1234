//
//  MERSetCardV.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERSetCardV.h"
#import "MERBaseCardV.h"

static const CGFloat SHAPES_BOUNDS_PERCENTAGE = 0.75;

@interface MERBaseCardV ()
- (CGFloat)widthScaleFactor;
- (CGFloat)heightScaleFactor;
@end

@implementation MERSetCardV

#pragma mark - Properties
- (void)setShape:(NSString *)shape
{
    if ([shape isEqualToString:@"A"]) {
        _shape = kDiamond;
    } else if ([shape isEqualToString:@"B"]) {
        _shape = kTwix;
    } else if ([shape isEqualToString:@"C"]) {
        _shape = kWing;
    } else {
        //
    }
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    if ([color isEqualToString:@"A"]) {
        _color = kGreen;
    } else if ([color isEqualToString:@"B"]) {
        _color = kBlue;
    } else if ([color isEqualToString:@"C"]) {
        _color = kGreen;
    } else {
        //
    }
    [self setNeedsDisplay];
}

- (void)setFill:(NSString *)fill
{
   if ([fill isEqualToString:@"A"]) {
        _fill = kFull;
    } else if ([_fill isEqualToString:@"B"]) {
        _fill = kHatch;
    } else if ([_fill isEqualToString:@"C"]) {
        _fill = kBlank;
    } else {
        //
    }
    [self setNeedsDisplay];
}

- (UIColor *)suitUIColor:(NSString *)colorString
{
    if ([colorString isEqualToString:kGreen]) {
        return [UIColor greenColor];
    } else if ([colorString isEqualToString:kBlue]) {
        return [UIColor blueColor];
    } else if ([colorString isEqualToString:kRed]) {
        return [UIColor redColor];
    } else {
        return [self.window tintColor];
    }
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
                [self pushContextCTMTranslateX:[self offsetShapeHorizontal] andY:0];
                
                if ([_shape isEqualToString:kDiamond]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:kTwix]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:kWing]) {
                    [self drawShapeWing];
                }
                
                [self popContext];
                break;
                
            case 2:
                [self pushContextCTMTranslateX:[self offsetShapeHorizontal] andY:[self shapeRect].size.height];
                
                if ([_shape isEqualToString:kDiamond]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:kTwix]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:kWing]) {
                    [self drawShapeWing];
                }
                
                [self popContext];
                break;
                
            case 3:
                [self pushContextCTMTranslateX:[self offsetShapeHorizontal] andY:[self shapeRect].size.height * 2];
                
                if ([_shape isEqualToString:kDiamond]) {
                    [self drawShapeDiamond];
                } else if ([_shape isEqualToString:kTwix]) {
                    [self drawShapeTwix];
                } else if ([_shape isEqualToString:kWing]) {
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

- (CGRect)shapeRect
{
#pragma TODO: To make autosized from based width and height consts
    // Create 1/3 sizes box for shape
    return CGRectMake(0, 0, self.bounds.size.width * SHAPES_BOUNDS_PERCENTAGE, self.bounds.size.height * SHAPES_BOUNDS_PERCENTAGE / 3);
}


- (CAShapeLayer *)baseShapeLayer
{
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.frame = [self shapeRect];
    shape.lineWidth = 1.0;
    shape.strokeColor = [self suitUIColor:_color].CGColor;
    
    if ([_fill isEqualToString:kFull]) {
        shape.fillColor = [self suitUIColor:_color].CGColor;
    
    } else if ([_fill isEqualToString:kHatch]) {
#pragma TODO: To make with CGPatterns
        shape.fillColor = [[self suitUIColor:_color] colorWithAlphaComponent:0.33].CGColor;
    
    } else if ([_fill isEqualToString:kBlank]) {
        shape.fillColor = [UIColor whiteColor].CGColor;
    
    } else {
       //
    }
    
    return shape;
}

- (void)drawShapeDiamond
{
    CAShapeLayer *shape = [self baseShapeLayer];
    CGFloat scaleFactor = shape.bounds.size.width / 100.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 20 * scaleFactor); // Left point
    CGPathAddLineToPoint(path, nil, 50 * scaleFactor, 0); // Top point
    CGPathAddLineToPoint(path, nil, 100 * scaleFactor, 20 * scaleFactor); // Right point
    CGPathAddLineToPoint(path, nil, 50 * scaleFactor, 40 * scaleFactor); // Bottom point
    CGPathCloseSubpath(path);

    shape.path = path;
    CGPathRelease(path);
    
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
    CAShapeLayer *shape = [self baseShapeLayer];
    CGFloat scaleFactor = shape.bounds.size.width / 100.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20 * scaleFactor, 0); // Left Top point
    CGPathAddLineToPoint(path, nil, 80 * scaleFactor, 0); // Right Top point
    CGPathAddQuadCurveToPoint(path, nil, 100 * scaleFactor, 20 * scaleFactor, 80 * scaleFactor, 40 * scaleFactor); // Right bottom point
    CGPathAddLineToPoint(path, nil, 20 * scaleFactor, 40 * scaleFactor); // Left bottom point
    CGPathAddQuadCurveToPoint(path, nil, 0, 20 * scaleFactor, 20 * scaleFactor, 0); // for closing with bezier
    CGPathCloseSubpath(path);

    shape.path = path;
    CGPathRelease(path);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [shape renderInContext:context];
}

- (void)drawShapeWing
{
    CAShapeLayer *shape = [self baseShapeLayer];
    CGFloat scaleFactor = shape.bounds.size.width / 100.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 60 * scaleFactor); // Bottom Left point
    CGPathAddQuadCurveToPoint(path, nil, 0, 20 * scaleFactor, 20 * scaleFactor, 20 * scaleFactor);
    CGPathAddLineToPoint(path, nil, 80 * scaleFactor, 20 * scaleFactor);
    CGPathAddQuadCurveToPoint(path, nil, 100 * scaleFactor, 20 * scaleFactor, 100 * scaleFactor, 0); // Top Right point
    CGPathAddQuadCurveToPoint(path, nil, 100 * scaleFactor, 40 * scaleFactor, 80 * scaleFactor, 40 * scaleFactor);
    CGPathAddLineToPoint(path, nil, 20 * scaleFactor, 40 * scaleFactor);
    CGPathAddQuadCurveToPoint(path, nil, 0, 40 * scaleFactor, 0, 60 * scaleFactor);
    
    CGPathCloseSubpath(path);

    shape.path = path;
    CGPathRelease(path);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [shape renderInContext:context];   
}

- (void)pushContextCTMTranslateX:(CGFloat)tX andY:(CGFloat)tY
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, tX, tY);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %@, %@, %lu", _shape, _color, _fill, _rank];
}

@end
