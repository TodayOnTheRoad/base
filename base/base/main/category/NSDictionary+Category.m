//
//  NSDictionary+Category.m
//  test
//
//  Created by 沈雁飞 on 16/3/9.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)
#pragma mark - 构造方法
+ (instancetype)dictionaryForPlistName:(NSString *)plistName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *dict = [self dictionaryWithContentsOfFile:filePath];
    return dict;
}
@end
