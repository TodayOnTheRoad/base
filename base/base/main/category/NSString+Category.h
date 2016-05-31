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
#pragma mark - 构造方法
/**
 *
 *  @param date 时间对象
 *
 *  @return 时间字符串 "yyyy-mm-dd  HH:mm"
 */
+ (instancetype)stringWithDate:(NSDate *)date;
#pragma mark - 字符串size 
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
#pragma mark - 沙盒路径
/**
 *  documents路径
 *
 *  @return documents路径
 */
+ (NSString *)documentsPath;
/**
 *  cache路径
 *
 *  @return cache 路径
 */
+ (NSString *)cachePath;
/**
 *  tmp路径
 *
 *  @return tmp路径
 */
+ (NSString *)tmpPath;
#pragma mark - 其他
- (BOOL)isContent;
- (instancetype)leachStringUseString:(NSString *)string;
@end
