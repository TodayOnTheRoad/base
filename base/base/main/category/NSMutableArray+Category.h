//
//  NSMutableArray+Category.h
//  test
//
//  Created by 沈雁飞 on 16/3/10.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Category)
#pragma mark - 排序
/**
 *  把一个数组的第几位放到第一位，别的依次往后排
 *
 *  @param index 数组的位数
 */
- (void)bringObjectToFront:(NSUInteger)index;
/**
 *  将数组最后一位删除，把新的对象加到第一位别的依次往后排
 *
 *  @param anObject 需要增加的对象
 */
- (void)addObjectAndDeleateLast:(id)anObject;
@end
