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
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = config.lineSpace;
    NSDictionary *attributes = @{NSFontAttributeName : config.font,
                                 NSForegroundColorAttributeName : config.textColor,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    return attributes;
}

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

+ (CoreTextData *)attributeStringWithJsonFilePath:(NSString *)path restrictWidth:(CGFloat)restrictWidth {
    NSAttributedString *string = [self attributeStringWithJsonFilePath:path];
    return [self parserAttributeString:string restrictWidth:restrictWidth];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)content config:(CTFrameParserConfig *)config {
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:content attributes:attributes];
    return [[NSAttributedString alloc]initWithAttributedString:attr];
}

+ (NSAttributedString *)attributeStringWithJsonFilePath:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *attr = [NSMutableAttributedString new];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dict in array) {
            [attr appendAttributedString:[self attributeStringWithDictionary:dict]];
        }
    }
    NSLog(@"attr:%@",attr);
    return attr;
}

+ (NSAttributedString *)attributeStringWithDictionary:(NSDictionary *)dict {
    if ([dict[@"type"]  isEqual: @"txt"]) {
        NSString *string = dict[@"content"];
        NSString *colorString = dict[@"color"];
        UIColor *color = [self colorWithString:colorString];
        NSNumber *fontNumber = dict[@"size"];
        UIFont *font;
        if (fontNumber.stringValue.length > 0) {
            font = [UIFont systemFontOfSize:15];
        }else{
            font = [UIFont systemFontOfSize:fontNumber.floatValue];
        }
        NSAttributedString *attr = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName : font,
                                                                                                 NSForegroundColorAttributeName : color}];
        return attr;
    }
    return nil;
}

+ (UIColor *)colorWithString:(NSString *)string {
    if ([string isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([string isEqualToString:@"red"]) {
        return [UIColor redColor];
    }else if ([string isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }else{
        return [UIColor blackColor];
    }
}

+ (CTFrameRef )creatFrameWithFramesetter:(CTFramesetterRef)framersetter restrictWidth:(CGFloat)restrictWidth height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, restrictWidth, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framersetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

//- (NSArray *)imageArrayWithJsonFilePath:(NSString *)path {
//    
//}
@end
