//
//  RSProgressCircle.m
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSProgressCircle.h"

@interface RSProgressCircle ()

- (CGFloat)degreesToRadians:(NSInteger)degrees;
- (void)drawText:(NSString*)text atPoint:(CGPoint)point font:(UIFont*)textFont;

@end

@implementation RSProgressCircle

// Constants
const NSInteger CIRCLE_STROKE_WIDTH = 20;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    NSInteger direction;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Circle dimensions
    CGRect allRect = self.bounds;
    CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
    CGFloat radius = (allRect.size.width - CIRCLE_STROKE_WIDTH) / 2;
    
    // The start and end angle to draw between.  Notice that we start at -90
    // degrees, which is straight up.
    NSInteger startAngle = -90;
    NSInteger endAngle = startAngle + _progress * 360.0;
    
    // If progress positive, we want a clockwise circle.  If it's negative, we
    // want a counter-clockwise circle.
    if (_progress >= 0) {
        direction = 0;  // clockwise
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    } else {
        direction = 1;  // anti-clockwise
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    }
    
    // Draw the circle.
    CGContextSetLineWidth(context, CIRCLE_STROKE_WIDTH);
    CGContextAddArc(context, center.x, center.y, radius, [self degreesToRadians:startAngle], [self degreesToRadians:endAngle], direction);
    CGContextStrokePath(context);

    // Draw the text.
    NSString *scoreString = [NSString stringWithFormat:@"%d", _score];
    [self drawText:scoreString atPoint:center font:[UIFont boldSystemFontOfSize:16.0]];
}

- (void)updateProgress:(CGFloat)nextProgress score:(NSInteger)nextScore {
    
    // This method is exported and gets called from outside of its class.  The
    // 'setNeedsDisplay' call causes our 'drawRect' method above to be called.
    
    _score = nextScore;
    _progress = nextProgress;
    [self setNeedsDisplay];
}

- (void)drawText:(NSString*)text atPoint:(CGPoint)point font:(UIFont*)textFont {
    
    // Find the width of our text.
    CGSize textSize = [text sizeWithFont:textFont];
    CGFloat textWidth = textSize.width;
    
    // Adjust where we draw the text, based on its width, so that it appears in
    // the middle of the rect.
    CGPoint textPoint = CGPointMake(point.x - textWidth / 2, point.y);
    
    // Now draw it.
    [text drawAtPoint:textPoint withFont:textFont];
}

- (CGFloat)degreesToRadians:(NSInteger)degrees {
    return degrees * M_PI / 180.0;
}

@end
