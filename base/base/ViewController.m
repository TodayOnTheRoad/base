//
//  ViewController.m
//  base
//
//  Created by 沈雁飞 on 16/4/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
static NSUInteger kMinTurn = 1;
static CGFloat itemWidth = 33;
static CGFloat itemHeight = 62;
@interface CheckInDaysView:UIImageView
@end

@implementation CheckInDaysView
{
    NSMutableArray  *_scrollLayerArray;
    NSMutableArray *_sourceArray;
    NSUInteger _iconCount;
    NSUInteger _numberOfLine;
    
    NSMutableArray  *_resultArray;
    NSMutableArray *_currentArray;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"CheckInDaysBackground"];
        [self loadData];
    }
    return self;
}
- (void)loadData
{
    _numberOfLine = 4;
    CGFloat itemSpacing = 18;
    _iconCount = 10;
    _scrollLayerArray = [NSMutableArray array];
    _sourceArray = [NSMutableArray array];
    for (int i = 0; i < _iconCount; i++) {
        NSString *string = [NSString stringWithFormat:@"%d",i];
        [_sourceArray addObject:string];
    }
    _currentArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    _resultArray = [NSMutableArray array];
    for (int i = 0; i < _numberOfLine; i++) {
        CALayer *containLayer = [[CALayer alloc]init];
        containLayer.frame = CGRectMake(i * (itemWidth + itemSpacing) + 40, 52, itemWidth, itemHeight);
        containLayer.masksToBounds = YES;
        [self.layer addSublayer:containLayer];
        
        CALayer *scrollLayer = [[CALayer alloc] init];
        scrollLayer.frame = CGRectMake(0, 0, itemWidth, itemHeight * _iconCount);
        [containLayer addSublayer:scrollLayer];
        
        [_scrollLayerArray addObject:scrollLayer];
    }
    
    
    for (int i = 0; i < _numberOfLine; i++) {
        CALayer *scrollLayer = [_scrollLayerArray objectAtIndex:i];
        NSInteger total = - (i + kMinTurn + 3) * _iconCount;
        for (int j = 0; j > total; j--) {
            CATextLayer *textLayer = [[CATextLayer alloc] init];
            NSInteger offsetYUnit = j + _iconCount;
            textLayer.frame = CGRectMake(0, offsetYUnit * itemHeight + itemHeight / 4 - 3, itemWidth, itemHeight);
            textLayer.backgroundColor = [UIColor clearColor].CGColor;
            textLayer.fontSize = 30;
            textLayer.foregroundColor = [UIColor blackColor].CGColor;
            textLayer.alignmentMode = @"center";
            [textLayer setString:[_sourceArray objectAtIndex:abs(j) % _iconCount]];
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            [scrollLayer addSublayer:textLayer];
        }

    }
}
- (void)startSliding {
    
        __block NSMutableArray *completePositionArray = [NSMutableArray array];
        
        [CATransaction begin];
        
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [CATransaction setDisableActions:YES];
        [CATransaction setCompletionBlock:^{
            for (int i = 0; i < [_scrollLayerArray count]; i++) {
                CALayer *scrollLayer = [_scrollLayerArray objectAtIndex:i];
                
                scrollLayer.position = CGPointMake(scrollLayer.position.x, ((NSNumber *)[completePositionArray objectAtIndex:i]).floatValue);
                
                NSMutableArray *toBeDeletedLayerArray = [NSMutableArray array];
                
                NSUInteger resultIndex = [[_resultArray objectAtIndex:i] integerValue];
                NSUInteger currentIndex = [[_currentArray objectAtIndex:i] integerValue];
                
                for (int j = 0; j < _iconCount * (kMinTurn + i) + resultIndex - currentIndex; j++) {
                    CATextLayer *iconLayer = (CATextLayer *)[scrollLayer.sublayers objectAtIndex:j];
                    [toBeDeletedLayerArray addObject:iconLayer];
                }
                
                for (CATextLayer *toBeDeletedLayer in toBeDeletedLayerArray) {
                    // use initWithLayer does not work
                    CATextLayer *toBeAddedLayer = [CATextLayer layer];
                    toBeAddedLayer.frame = toBeDeletedLayer.frame;
                    toBeAddedLayer.backgroundColor = toBeDeletedLayer.backgroundColor;
                    toBeAddedLayer.fontSize = toBeDeletedLayer.fontSize;
                    toBeAddedLayer.foregroundColor = toBeDeletedLayer.foregroundColor;
                    toBeAddedLayer.alignmentMode = toBeDeletedLayer.alignmentMode;
                    [toBeAddedLayer setString:toBeDeletedLayer.string];
                    
                    CGFloat shiftY = _iconCount * toBeAddedLayer.frame.size.height * (kMinTurn + i + 3);
                    toBeAddedLayer.position = CGPointMake(toBeAddedLayer.position.x, toBeAddedLayer.position.y - shiftY);
                    
                    [toBeDeletedLayer removeFromSuperlayer];
                    [scrollLayer addSublayer:toBeAddedLayer];
                }
            }
            
            [_currentArray removeAllObjects];
            [_currentArray addObjectsFromArray:_resultArray];
            completePositionArray = [NSMutableArray array];
        }];
        
        static NSString * const keyPath = @"position.y";
        
        for (int i = 0; i < [_scrollLayerArray count]; i++) {
            CALayer *scrollLayer = [_scrollLayerArray objectAtIndex:i];
            
            NSUInteger resultIndex = [[_resultArray objectAtIndex:i] integerValue];
            NSUInteger currentIndex = [[_currentArray objectAtIndex:i] integerValue];
            
            NSUInteger howManyUnit =  (i + kMinTurn) * _iconCount +resultIndex - currentIndex;
            CGFloat slideY = howManyUnit * itemHeight;
            
            CABasicAnimation *slideAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
            slideAnimation.fillMode = kCAFillModeForwards;
            slideAnimation.duration = howManyUnit * 0.14;
            slideAnimation.toValue = [NSNumber numberWithFloat:scrollLayer.position.y + slideY];
            slideAnimation.removedOnCompletion = NO;
            
            [scrollLayer addAnimation:slideAnimation forKey:@"slideAnimation"];
            
            [completePositionArray addObject:slideAnimation.toValue];
        }
        
        [CATransaction commit];
}

- (void)setDaysString:(NSString *)string
{
    [_resultArray removeAllObjects];
    NSString *newstring = [NSString stringWithFormat:@"0000%@",string];
    for (int i = 0; i < _numberOfLine; i++) {
        NSString *string = [newstring substringWithRange:NSMakeRange(newstring.length - (_numberOfLine - i), 1)];
        [_resultArray addObject:string];
    }
    [self startSliding];
    
}
@end

@interface ViewController ()

@end

@implementation ViewController
{
    UIView *_redView;
    UIImageView  *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 266, 50)];
    UIImage *image= [UIImage imageNamed:@"CheckInDaysBackground"];
//    CGFloat scale = image.scale;
//    CGImageRef cgImage = image.CGImage;
//    CGImageRef newCgImage = CGImageCreateWithImageInRect(cgImage, CGRectMake(0, 0, 532, 100));
//    _imageView.layer.contentsScale = 2.0f;
    _imageView.image = [image subImageWithRect:CGRectMake(0, 0, 266, 50)];
    
    
    [self.view addSubview:_imageView];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
