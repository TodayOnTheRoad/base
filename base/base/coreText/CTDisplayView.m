//
//  CTDisplayView.m
//  base
//
//  Created by 沈雁飞 on 16/10/9.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetFillColorWithColor(context ,[UIColor redColor].CGColor);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"HelloWorld""hahaha""test \n  wocao"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attr length]), path, NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}
@end
