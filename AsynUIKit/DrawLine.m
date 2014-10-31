//
//  DrawLine.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/30.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "DrawLine.h"

@implementation DrawLine


+ (void)drawDashLine:(CGContextRef)context start:(CGPoint)start End:(CGPoint)end Color:(UIColor *)color Width:(float)width Length:(CGFloat*)lengths
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL,  end.x, end.y);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}


+ (void)drawLine:(CGContextRef)context start:(CGPoint)start End:(CGPoint)end Color:(UIColor *)color Width:(float)width
{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
}

@end
