//
//  ViewController.m
//  base
//
//  Created by 沈雁飞 on 16/4/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation ViewController

{
    UITableView  *_tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog_Point(velocity);

}
@end
