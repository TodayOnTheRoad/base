//
//  UIImage+Category.h
//  base
//
//  Created by 沈雁飞 on 16/4/29.
//  Copyright © 2016年 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  返回切割后的图片
 *
 *  @param image 原图片
 *  @param rect  切图片的rect
 *
 *  @return 切过的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image rect:(CGRect)rect;
/**
 *  返回切割后的图片
 *
 *  @param image 原图片的名字
 *  @param rect  切图片的rect
 *
 *  @return 切过的图片
 */
+ (UIImage *)imageNamed:(NSString *)name rect:(CGRect)rect;
/**
 *  返回切割后的图片
 *
 *  @param rect 切图片的rect
 *
 *  @return 切过的图片
 */
- (UIImage *)subImageWithRect:(CGRect)rect;
@end
