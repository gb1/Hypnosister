//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Gregor Brett on 20/03/2013.
//  Copyright (c) 2013 Gregor Brett. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)setCircleColor:(UIColor *)clr{
    circleColor = clr;
    [self setNeedsDisplay];
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(motion == UIEventSubtypeMotionShake){
        NSLog(@"shake!");
        [self setCircleColor:[UIColor redColor]];
    }
}

-(void)drawRect:(CGRect)dirtyRect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    //figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    //line 10 points thick
    CGContextSetLineWidth(ctx, 10);
    
    //colour grey
    //CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
    [[self circleColor]setStroke];
    
    //add a shape to the context
    //CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    //CGContextStrokePath(ctx);
    
    //draw concentric circles from the outside in
    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        //add a path to the context
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(ctx);
    }
    
    //create a string
    NSString *text = @"You are getting sleepy";
    
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    
    textRect.size = [text sizeWithFont:font];
    
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    [[UIColor blackColor] setFill];
    
    //add a shadow
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    [text drawInRect:textRect withFont:font];
    
}

@end
