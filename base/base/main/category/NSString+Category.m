//
//  NSString+Category.m
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
#pragma mark - 构造方法
+ (instancetype)stringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd  HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
#pragma mark - 字符串size 
- (CGSize)mySizeWithFont:(UIFont *)font {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self sizeWithAttributes:attributes];
}

- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedSize {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:constrainedSize
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
            | NSStringDrawingUsesFontLeading
                           attributes:attributes
                              context:nil].size;
}

-(CGSize)mySizeWithFont:(UIFont *)font withWidth:(CGFloat)width
{
    CGSize resultSize = [self mySizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    return resultSize;
}
#pragma mark - 沙盒路径
+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    return documentsPath;
}
+ (NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths firstObject];
    return cachePath;
}
+ (NSString *)tmpPath
{
    NSString *tmpPath = NSTemporaryDirectory();
    return tmpPath;
}
#pragma mark - 其他
-(BOOL)isContent
{
    if (self == nil) {
        return NO;
    }else{
        //去掉字符串空格
        NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        //去掉换行符
        NSString *resultString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if ([resultString isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (instancetype)leachStringUseString:(NSString *)string
{
     return [[self componentsSeparatedByString:string] componentsJoinedByString:@""];
}
@end
