//
//  CTFrameParserConfig.m
//  base
//
//  Created by 沈雁飞 on 16/10/16.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig
-(instancetype)init
{
    if (self = [super init]) {
        
        _font = [UIFont systemFontOfSize:17.0f];
        _textColor = [UIColor blackColor];
        _width = [UIScreen mainScreen].bounds.size.width;
        _lineSpace = 8.0f;
        
    }
    return self;
    
}
@end
