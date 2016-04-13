//
//  NSString+Category.h
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Category)
/**
 *  计算字符串size
 *
 *  @param font 字体
 *
 *  @return size
 */
- (CGSize)mySizeWithFont:(UIFont *)font;
/**
 *  计算字符串size
 *
 *  @param font   字体
 *  @param constrainedSize 最大的size
 *
 *  @return size
 */
- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedSize;
/**
 *  计算字符串size
 *
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return size
 */
- (CGSize)mySizeWithFont:(UIFont *)font withWidth:(CGFloat)width;
/**
 *  字符串里面是否有内容(空格不算）
 *
 *  @return yes是有
 */
- (BOOL)isContent;
@end
