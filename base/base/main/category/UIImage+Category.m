//
//  UIImage+Category.m
//  base
//
//  Created by 沈雁飞 on 16/4/29.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+ (UIImage *)imageWithImage:(UIImage *)image rect:(CGRect)rect
{
    CGImageRef cgImage = image.CGImage;
    CGFloat scale = image.scale;
    CGFloat x      = rect.origin.x * scale;
    CGFloat y      = rect.origin.y * scale;
    CGFloat width  = rect.size.width * scale;
    CGFloat height = rect.size.height * scale;
    cgImage = CGImageCreateWithImageInRect(cgImage, CGRectMake(x, y, width, height));
    return [UIImage imageWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp];
}

+ (UIImage *)imageNamed:(NSString *)name rect:(CGRect)rect
{
    return [UIImage imageWithImage:[UIImage imageNamed:name] rect:rect];
}

- (UIImage *)subImageWithRect:(CGRect)rect
{
    return [UIImage imageWithImage:self rect:rect];
}
@end
