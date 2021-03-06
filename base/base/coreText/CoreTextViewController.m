//
//  CoreTextViewController.m
//  base
//
//  Created by 沈雁飞 on 16/10/9.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"

@implementation CoreTextViewController
{
    CTDisplayView  *_displayView;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"CoreText";
    
    
    _displayView = [[CTDisplayView alloc]initWithFrame:CGRectMake(100, 100, 200, 0)];
    _displayView.backgroundColor = [UIColor whiteColor];
    
//    CTFrameParserConfig *config = [CTFrameParserConfig new];
//    config.textColor = [UIColor greenColor];
//    config.lineSpace = 20;
//    config.width = 100;
//    
////    CoreTextData *data = [CTFrameParser parserString:@"哈哈哈哈哈哈撒好大声大声的撒打算的打算打算的" config:config];
//    NSString *string = @"哈哈哈哈哈哈撒好大声大声的撒打算的打算打算的";
//    NSDictionary *dict = [CTFrameParser attributesWithConfig:config];
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:string attributes:dict];
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//    CoreTextData *data = [CTFrameParser parserAttributeString:attr restrictWidth:100];    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestCoreText" ofType:@"json"];
    CoreTextData *data = [CTFrameParser attributeStringWithJsonFilePath:path restrictWidth:200];
    

    _displayView.data = data;
    _displayView.height = data.height;
    
    [self.view addSubview:_displayView];
}
@end
