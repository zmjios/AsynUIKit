//
//  FirstViewController.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/27.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "FirstViewController.h"
#import <AsyncDisplayKit/ASImageNode.h>
#import <AsyncDisplayKit/ASTextNode.h>


#import "ImageTextView.h"
#import "ImageTextNode.h"
#import "UIColor+RandomColor.h"
#import "NSObject+MKBlockTimer.h"


@interface FirstViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ASImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *shuffleNode;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    
//    [self addImageView];
//    
//    [self addImageNode];
//    
//    [self addTextNode];
    
    
    //[self addImageTextView];
    
    
    [self addIMageTextNode];
    
    
    
//    [self logTimeTakenToRunBlock:^{
//        
//        [self add10000View];
//        
//    } withPrefix:@"For add View"];
    
    
//    [self logTimeTakenToRunBlock:^{
//        
//        [self add10000Node];
//        
//    } withPrefix:@"For add Node"];
    
    
    
    //[self add10000Node];
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addTextNode
{
    NSDictionary *attrs = @{
                            NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                            NSForegroundColorAttributeName: [UIColor redColor],
                            };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"shuffle abcdefghijklmnopqrst"
                                                                 attributes:attrs];
    
    // create the node
    _shuffleNode = [[ASTextNode alloc] init];
    _shuffleNode.attributedString = string;
    _shuffleNode.backgroundColor = [UIColor blueColor];
    
    // configure the button
    _shuffleNode.userInteractionEnabled = YES; // opt into touch handling
    [_shuffleNode addTarget:self
                     action:@selector(buttonTapped:)
           forControlEvents:ASControlNodeEventTouchUpInside];
    
    // size all the things
    CGRect b = self.view.bounds; // convenience
    CGSize size = [_shuffleNode measure:CGSizeMake(b.size.width, FLT_MAX)];
    CGPoint origin = CGPointMake(roundf( (b.size.width - size.width) / 2.0f ),
                                 roundf( (b.size.height - size.height) / 2.0f ));
    _shuffleNode.frame = (CGRect){ origin, size };
    
    
    // add to our view
    [self.view addSubview:_shuffleNode.view];
    
    
    // make the tap target taller
    CGFloat extendY = roundf( (88.0f - size.height) / 2.0f );
    _shuffleNode.hitTestSlop = UIEdgeInsetsMake(-extendY, 0.0f, -extendY, 0.0f);

}



- (void)addImageView
{
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"hello.jpg"];
    _imageView.frame = CGRectMake(20.0f, 100.0f, 200.0f, 200.0f);
    [self.view addSubview:_imageView];
}


- (void)addImageNode
{
    _imageNode = [[ASImageNode alloc] init];
    _imageNode.backgroundColor = [UIColor lightGrayColor];
    _imageNode.image = [UIImage imageNamed:@"hello.jpg"];
    _imageNode.frame = CGRectMake(20.0f, 100.0f, 200.0f, 200.0f);
    [self.view addSubview:_imageNode.view];
}


- (void)buttonTapped:(id)sender
{
    NSLog(@"tapped!");
}



- (void)addImageTextView
{
    ImageTextView *view = [[ImageTextView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 200)];
    //[view sizeToFit];
    [self.view addSubview:view];
}


- (void)addIMageTextNode
{
    ImageTextNode *node = [[ImageTextNode alloc] init];
    node.frame = CGRectMake(0, 300, self.view.bounds.size.width, 200);
    [node measure:node.frame.size];
    [self.view addSubview:node.view];
}





- (void)add10000View
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    int totalRows = 10000;
    int totalColumns  = 10;
    
    CGFloat x = (self.view.bounds.size.width - 20*totalColumns)/(totalColumns + 1);
    CGFloat y = 0;
    CGFloat w = 20;
    CGFloat h = 20;
    
    for (int i = 0; i < totalRows; i ++) {
        
        for (int j = 0 ; j < totalColumns; j ++) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x + j *(w+x), y + i * (h + x), w, h)];
            view.backgroundColor = [UIColor randomColor];
            view.tag = totalColumns*i + j;
            [scrollView addSubview:view];
        }
    }
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, totalRows*(x+h));
    [self.view addSubview:scrollView];
}


- (void)add10000Node
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    int totalRows = 10000;
    int totalColumns  = 10;
    
    CGFloat x = (self.view.bounds.size.width - 20*totalColumns)/(totalColumns + 1);
    CGFloat y = 0;
    CGFloat w = 20;
    CGFloat h = 20;
    

    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, totalRows*(x+h));
    [self.view addSubview:scrollView];
    
    
    
    for (int i = 0; i < totalRows; i ++) {
        
        for (int j = 0 ; j < totalColumns; j ++) {
            
            ASDisplayNode *node = [[ASDisplayNode alloc] init];
            node.backgroundColor = [UIColor randomColor];
            node.frame = CGRectMake(x + j *(w+x), y + i * (h + x), w, h);
            [node measure:node.frame.size];
            [scrollView addSubview:node.view];
        
        }
    }
    
    

    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *nodeList = [NSMutableArray array];
        
        for (int i = 0; i < totalRows; i ++) {
            
            for (int j = 0 ; j < totalColumns; j ++) {
                
                ASDisplayNode *node = [[ASDisplayNode alloc] init];
                node.backgroundColor = [UIColor randomColor];
                node.frame = CGRectMake(x + j *(w+x), y + i * (h + x), w, h);
                [node measure:node.frame.size];
                [nodeList addObject:node];
            }
        }
      
        dispatch_async(dispatch_get_main_queue(), ^{
           
            for (int i = 0; i < totalRows; i ++)
            {
                for (int j = 0; j < totalColumns; j ++)
                {
                    ASDisplayNode *node = [nodeList objectAtIndex:(totalColumns*i + j)];
                    [scrollView addSubview:node.view];
                }
            }
        });
        
    });*/

}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
