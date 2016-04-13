//
//  NSString+Category.m
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
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
@end
