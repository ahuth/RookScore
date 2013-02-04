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
- (void)drawCircleAtPoint:(CGPoint)point fromRadians:(CGFloat)start toRadians:(CGFloat)end withRadius:(CGFloat)radius withWidth:(NSInteger)width withColor:(UIColor *)color clockwise:(BOOL)clockwise;
- (CGPoint)getPointFromCenter:(CGPoint)center atDegrees:(NSInteger)degrees fromRadius:(CGFloat)radius;

@end

@implementation RSProgressCircle

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
    
    NSString *scoreString = [NSString stringWithFormat:@"%d", _score];
    NSString *teamString = [NSString stringWithFormat:@"Team %d", _team];
    
    // Circle dimensions
    const NSInteger strokeWidth = 20;
    const CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    const CGFloat radius = (self.bounds.size.width - strokeWidth) / 2;
    
    // The start and end angle to draw between.  Notice that we start at -90
    // degrees, which is straight up.
    const NSInteger startAngle = -90;
    const NSInteger endAngle = startAngle + _progress * 360.0;
    
    if (_progress == 0) {
        
        // Game is just starting, so only draw the team label.
        
        [self drawCenteredText:teamString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:self.bounds];

    } else if (_progress < 1) {
        
        // We're in the middle of a game, so draw the circle, the team label, and
        // the score.
        
        const NSInteger offsetAngle = (_progress < 0) ? -10 : 10;
        const BOOL drawClockwise = (_progress < 0) ? NO : YES;
        UIColor *drawColor = (_progress < 0) ? [UIColor blueColor] : [UIColor redColor];
        
        [self drawCircleAtPoint:center
                    fromRadians:[self degreesToRadians:startAngle]
                      toRadians:[self degreesToRadians:endAngle]
                     withRadius:radius
                      withWidth:strokeWidth
                      withColor:drawColor
                      clockwise:drawClockwise];
        
        [self drawCenteredText:teamString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:self.bounds];
        
        CGPoint textPoint = [self getPointFromCenter:center
                                           atDegrees:(endAngle + offsetAngle)
                                          fromRadius:radius];
        
        [self drawCenteredText:scoreString
                       atPoint:textPoint
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:self.bounds];
        
    } else {
        
        // Game is over, so don't draw the team label.
        
        [self drawCircleAtPoint:center
                    fromRadians:[self degreesToRadians:startAngle]
                      toRadians:[self degreesToRadians:(startAngle + 360)]
                     withRadius:radius
                      withWidth:strokeWidth
                      withColor:[UIColor redColor]
                      clockwise:YES];
        
        [self drawCenteredText:scoreString
                       atPoint:center
                      withFont:[UIFont boldSystemFontOfSize:20.0]
                        inRect:self.bounds];
    }
}

- (void)drawCircleAtPoint:(CGPoint)point fromRadians:(CGFloat)start toRadians:(CGFloat)end withRadius:(CGFloat)radius withWidth:(NSInteger)width withColor:(UIColor *)color clockwise:(BOOL)clockwise {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    
    if (clockwise) {
        CGContextAddArc(context, point.x, point.y, radius, start, end, 0);
    } else {
        CGContextAddArc(context, point.x, point.y, radius, end, start, 0);
    }
    
    CGContextStrokePath(context);
}

- (void)drawCenteredText:(NSString*)text atPoint:(CGPoint)point withFont:(UIFont*)textFont inRect:(CGRect)aRect {
    
    const CGSize textSize = [text sizeWithFont:textFont];
    
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

    const CGFloat x = center.x + radius * cos([self degreesToRadians:degrees]);
    const CGFloat y = center.y + radius * sin([self degreesToRadians:degrees]);
    
    return CGPointMake(x, y);
}

#pragma mark -
#pragma mark API

- (void)initWithTeam:(NSInteger)teamNum {
    _team = teamNum;
    [self setNeedsDisplay];
}

- (void)updateProgress:(CGFloat)nextProgress score:(NSInteger)nextScore {
    
    _score = nextScore;
    _progress = nextProgress;
    
    // setNeedsDisplay causes our drawRect method above to be called.
    [self setNeedsDisplay];
}

@end
