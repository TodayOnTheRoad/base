//
//  UIView+Category.m
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
#pragma mark - size相关
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGSize)size
{
    return self.frame.size;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
#pragma mark - 其他
//设置部分圆角
//- (void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners
//{
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//    maskPath.lineWidth = 2;
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.layer.mask = maskLayer;
//    self.layer.masksToBounds = YES;
//}
//- (void)setBorderLineWithBorderLinetype:(ViewBorderLinetype)type
//{
//    if (!type || type == ViewBorderLinetypeNone) {
//        return;
//    }
//    CGFloat borderWidth = self.layer.borderWidth ? self.layer.borderWidth : 1.0;
//    CGFloat width  = self.width  + 2 *borderWidth;
//    CGFloat height = self.height + 2 *borderWidth;
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//    [self addSubview:imageView];
//    imageView.userInteractionEnabled = YES;
//    [imageView.image drawInRect:CGRectMake(0, 0, width,height)];
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetLineCap(ctx, kCGLineCapRound);  //边缘样式
//    CGContextSetLineWidth(ctx, 1.0);  //线宽
//    CGContextSetAllowsAntialiasing(ctx, YES);
//    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);  //颜色
//
//    switch (type) {
//        case ViewBorderLinetypeTop:
//            CGContextBeginPath(ctx);
//            CGContextMoveToPoint(ctx, 0, 0);  //起点坐标
//            CGContextAddLineToPoint(ctx, width, 0);   //终点坐标
//            CGContextStrokePath(ctx);
//            break;
//        case ViewBorderLinetypeLeft:
//            CGContextBeginPath(ctx);
//            CGContextMoveToPoint(ctx, 0, 0);  //起点坐标
//            CGContextAddLineToPoint(ctx, 0, height);   //终点坐标
//            CGContextStrokePath(ctx);
//            break;
//        case ViewBorderLinetypeBottom:
//            CGContextBeginPath(ctx);
//            CGContextMoveToPoint(ctx, 0, height);  //起点坐标
//            CGContextAddLineToPoint(ctx, width, height);   //终点坐标
//            CGContextStrokePath(ctx);
//            break;
//        case ViewBorderLinetypeRight:
//            CGContextBeginPath(ctx);
//            CGContextMoveToPoint(ctx, width, 0);  //起点坐标
//            CGContextAddLineToPoint(ctx, width, height);   //终点坐标
//            CGContextStrokePath(ctx);
//            break;
//            
//        default:
//            break;
//    }
//    
//    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//}
@end
