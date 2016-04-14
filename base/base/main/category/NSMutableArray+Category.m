//
//  NSMutableArray+Category.m
//  test
//
//  Created by 沈雁飞 on 16/3/10.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSMutableArray+Category.h"

@implementation NSMutableArray (Category)
- (void)bringObjectToFront:(NSUInteger)index
{
    if (index >= self.count) return;
    NSMutableArray *array = [NSMutableArray arrayWithObject:[self objectAtIndex:index]];
    for (int i = 0; i < self.count; i++) {
        if (i == index) continue;
        id objc = [self objectAtIndex:i];
        [array addObject:objc];;
    }
    [self setArray:array];
}
- (void)addObjectAndDeleateLast:(id)anObject
{
    [self insertObject:anObject atIndex:0];
    [self removeLastObject];
}
@end
