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
    
    
    _displayView = [[CTDisplayView alloc]initWithFrame:CGRECT_TEST];
    _displayView.backgroundColor = [UIColor whiteColor];
    
    CTFrameParserConfig *config = [CTFrameParserConfig new];
    config.textColor = [UIColor redColor];
    config.lineSpace = 20;
    config.width = 100;
    
    CoreTextData *data = [CTFrameParser parserContent:@"哈哈哈哈哈哈撒好大声大声的撒打算的打算打算的" config:config];
    _displayView.data = data;
    
    [self.view addSubview:_displayView];
}
@end
