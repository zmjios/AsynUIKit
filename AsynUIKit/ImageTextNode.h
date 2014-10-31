//
//  ImageTextNode.h
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/27.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "ASDisplayNode.h"
#import <AsyncDisplayKit/ASTextNode.h>
#import <AsyncDisplayKit/ASImageNode.h>

@interface ImageTextNode : ASDisplayNode


@property (nonatomic, strong) ASImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *textNode;

@end
