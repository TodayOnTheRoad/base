//
//  CTDisplayView.m
//  base
//
//  Created by 沈雁飞 on 16/10/9.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextData.h"

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (_data) {
        CTFrameDraw(_data.ctFrame, context);
    }
}
@end
