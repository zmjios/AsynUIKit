//
//  UIColor+RandomColor.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/31.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)


+(UIColor *) randomColor
{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
