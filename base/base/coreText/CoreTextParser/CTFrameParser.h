//
//  CTFrameParser.h
//  base
//
//  Created by 沈雁飞 on 16/10/16.
//  Copyright © 2016年 syf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreTextData;
@class CTFrameParserConfig;

@interface CTFrameParser : NSObject

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

+ (CoreTextData *)parserString:(NSString *)string config:(CTFrameParserConfig *)config;

+ (CoreTextData *)parserAttributeString:(NSAttributedString *)attributeString restrictWidth:(CGFloat)restrictWidth;

+ (CoreTextData *)attributeStringWithJsonFilePath:(NSString *)path restrictWidth:(CGFloat)restrictWidth;
@end
