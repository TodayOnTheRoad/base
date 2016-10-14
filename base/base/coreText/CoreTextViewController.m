//
//  CoreTextViewController.m
//  base
//
//  Created by 沈雁飞 on 16/10/9.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CTDisplayView.h"

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
    [self.view addSubview:_displayView];
}
@end
