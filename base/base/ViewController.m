//
//  ViewController.m
//  base
//
//  Created by 沈雁飞 on 16/4/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *resourceArray;

@end

@implementation ViewController
{
    UITableView *_tableView;
}

-(instancetype)init {
    if (self = [super init]) {
        
        NSDictionary *dict = @{@"classString" : @"TestViewController",
                                @"text" : @"Test"};
        
        NSDictionary *dict1 = @{@"classString" : @"CoreTextViewController",
                                @"text" : @"CoreText"};
        NSDictionary *dict2 = @{@"classString" : @"DownLoadViewController",
                                @"text" : @"DownLoad"};
        self.resourceArray = [NSMutableArray arrayWithObjects:dict, dict1, dict2, nil];
        
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.view.bounds;
    _tableView = [[UITableView alloc]initWithFrame:rect];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];

    
}

#pragma mark - tableViewDelegate && datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"square";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.resourceArray[indexPath.row];
    cell.textLabel.text = dict[@"text"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.resourceArray[indexPath.row];
    UIViewController *v = [[NSClassFromString(dict[@"classString"]) alloc]init];
    if (v) {
        [self.navigationController pushViewController:v animated:YES];
    }
    
}
@end
