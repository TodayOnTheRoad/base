//
//  CoreTextData.h
//  base
//
//  Created by 沈雁飞 on 16/10/16.
//  Copyright © 2016年 syf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CoreTextData : NSObject

@property(nonatomic, assign) CTFrameRef ctFrame;

@property(nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *imageArray;

@end
