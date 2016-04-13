//
//  NSDate+extention.m
//  test
//
//  Created by 沈雁飞 on 16/1/25.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)
-(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd  HH:mm"];
    NSString *dateString = [formatter stringFromDate:self];
    return dateString;
}
@end
