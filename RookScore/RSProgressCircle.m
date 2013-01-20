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
- (void)drawCenteredText:(NSString*)text atPoint:(CGPoint)point withFont:(UIFont*)textFont inRect:(CGRect)aRect;
- (CGPoint)getPointFromCenter:(CGPoint)center atDegrees:(NSInteger)degrees fromRadius:(CGFloat)radius;

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

#pragma mark -
#pragma mark Drawing actions

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    NSInteger direction;
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *scoreString = [NSString stringWithFormat:@"%d", _score];
    NSString *teamString = [NSString stringWithFormat:@"Team %d", _team];
    
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
    
    // Draw text to identify the team and the score.  Where we draw these depends
    // on if the game is starting, in progress, or over.
    if (_progress == 0) {
        
        // Game is just starting, so only draw the team label.
        [self drawCenteredText:teamString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:allRect];
        
    } else if (_progress < 1) {
        
        // Offset the text we'll draw by 10 degrees from the edge of our partial
        // circle, so that we're not drawing text over the circle.
        CGPoint textPoint = [self getPointFromCenter:center
                                           atDegrees:(endAngle + 10)
                                          fromRadius:radius];
        
        [self drawCenteredText:teamString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:allRect];
        
        [self drawCenteredText:scoreString
                       atPoint:textPoint
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:allRect];
        
    } else {
        
        // Game is over, so just draw the score.
        [self drawCenteredText:scoreString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:allRect];
    }
}

- (void)drawCenteredText:(NSString*)text atPoint:(CGPoint)point withFont:(UIFont*)textFont inRect:(CGRect)aRect {
    
    CGSize textSize = [text sizeWithFont:textFont];
    
    // Set where we draw the text so that it's centered on the point parameter.
    CGPoint textPoint = CGPointMake(point.x - textSize.width / 2, point.y - textSize.height / 2);
    
    // Adjust the point, if necessary, to be within x-axis of aRect.
    if (textPoint.x < 0) {
        textPoint.x = 0;
    } else if (textPoint.x + textSize.width > aRect.size.width) {
        textPoint.x = aRect.size.width - textSize.width;
    }

    // Adjust the point, if necessary, to be within y-axis of aRect.
    if (textPoint.y < 0) {
        textPoint.y = 0;
    } else if (textPoint.y + textSize.height > aRect.size.height) {
        textPoint.y = aRect.size.height - textSize.height;
    }
    
    // Now draw it.
    [text drawAtPoint:textPoint withFont:textFont];
}

#pragma mark -
#pragma mark Geometry

- (CGFloat)degreesToRadians:(NSInteger)degrees {
    return degrees * M_PI / 180.0;
}

- (CGPoint)getPointFromCenter:(CGPoint)center atDegrees:(NSInteger)degrees fromRadius:(CGFloat)radius {
    
    // Get the coordinates of a point on a circle.
    
    degrees = (_score < 0) ? -degrees : degrees;

    CGFloat x = center.x + radius * cos([self degreesToRadians:degrees]);
    CGFloat y = center.y + radius * sin([self degreesToRadians:degrees]);
    
    return CGPointMake(x, y);
}

#pragma mark -
#pragma mark API

- (void)initWithTeam:(NSInteger)teamNum {
    _team = teamNum;
    [self setNeedsDisplay];
}

- (void)updateProgress:(CGFloat)nextProgress score:(NSInteger)nextScore {
    
    // setNeedsDisplay causes our drawRect method above to be called.
    
    _score = nextScore;
    _progress = nextProgress;
    [self setNeedsDisplay];
}

@end
