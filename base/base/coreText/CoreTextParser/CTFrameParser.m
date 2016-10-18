//
//  CTFrameParser.m
//  base
//
//  Created by 沈雁飞 on 16/10/16.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CTFrameParser.h"
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

@implementation CTFrameParser
+ (CoreTextData *)parserString:(NSString *)string config:(CTFrameParserConfig *)config {
    NSAttributedString *attr = [self attributedStringWithString:string config:config];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attr);
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, attr.length), nil, restrictSize, nil);
    CGFloat coreTextHeight = coreTextSize.height;
    CTFrameRef frame = [self creatFrameWithFramesetter:framesetter restrictWidth:config.width height:coreTextHeight];
    CoreTextData *data = [CoreTextData new];
    data.ctFrame = frame;
    data.height = coreTextHeight;
    CFRelease(framesetter);
    CFRelease(frame);
    return data;
}

+ (CoreTextData *)parserAttributeString:(NSAttributedString *)attributeString restrictWidth:(CGFloat)restrictWidth {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CGSize restrictSize = CGSizeMake(restrictWidth, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, attributeString.length), nil, restrictSize, nil);
    CGFloat coreTextHeight = coreTextSize.height;
    CTFrameRef frame = [self creatFrameWithFramesetter:framesetter restrictWidth:restrictWidth height:coreTextHeight];
    CoreTextData *data = [CoreTextData new];
    data.ctFrame = frame;
    data.height = coreTextHeight;
    CFRelease(framesetter);
    CFRelease(frame);
    return data;
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)content config:(CTFrameParserConfig *)config {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = config.lineSpace;
    NSDictionary *attributes = @{NSFontAttributeName : config.font,
                                 NSForegroundColorAttributeName : config.textColor,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:content attributes:attributes];
    return [[NSAttributedString alloc]initWithAttributedString:attr];
}

+ (CTFrameRef )creatFrameWithFramesetter:(CTFramesetterRef)framersetter restrictWidth:(CGFloat)restrictWidth height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, restrictWidth, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framersetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}
@end
