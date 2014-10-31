//
//  DrawLine.h
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/30.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DrawLine : NSObject


+ (void)drawDashLine:(CGContextRef)context start:(CGPoint)start End:(CGPoint)end Color:(UIColor *)color Width:(float)width Length:(CGFloat*)lengths;


+ (void)drawLine:(CGContextRef)context start:(CGPoint)start End:(CGPoint)end Color:(UIColor *)color Width:(float)width;

@end
