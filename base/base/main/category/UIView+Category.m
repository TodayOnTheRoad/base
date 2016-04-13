//
//  UIView+Category.m
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)


- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
//    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame = self.bounds;
//    maskLayer.path = path.CGPath;
//    self.layer.mask = maskLayer;
    
}

@end
