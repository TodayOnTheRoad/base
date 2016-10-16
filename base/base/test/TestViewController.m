//
//  TestViewController.m
//  base
//
//  Created by 沈雁飞 on 16/10/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "TestViewController.h"
#import "TestString.h"

@implementation TestViewController
{
    UIButton  *_downloadButton;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self loadData];
    [self loadAllSubViews];
}

- (void)loadData{
    
}

- (void)loadAllSubViews {
    _downloadButton = [[UIButton alloc]init];
    [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [_downloadButton setBackgroundColor:[UIColor greenColor]];
    _downloadButton.frame = CGRectMake(0, 100, 375, 30);
    [_downloadButton addTarget:self action:@selector(downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadButton];
    
    
    [self loadAllConstrain];
}

-(void)loadAllConstrain {
    
}

- (void)downloadButtonClick {
    TestString *string1 = [[TestString alloc] init];
    string1.number = [NSNumber numberWithInt:10];
    NSLog(@"%p",string1);
    [string1 test];
    void (^myblock)() = ^(){
        NSLog(@"我在这里");
        NSLog(@"%p",string1);
        [string1 test];
        string1.number = [NSNumber numberWithInt:11];
        NSLog(@"里面%@",string1.number);
    };
    
    myblock();
    NSLog(@"外面%@",string1.number);
}
@end
