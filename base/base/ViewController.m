//
//  ViewController.m
//  base
//
//  Created by 沈雁飞 on 16/4/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface CheckInDaysView:UIImageView

@end

@implementation CheckInDaysView
{
    UILabel  *_firstLabel;
    UILabel  *_secondLabel;
    UILabel  *_thirdLabel;
    UILabel  *_lastLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"CheckInDaysBackground"];
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.backgroundColor = [UIColor clearColor];
        _firstLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:_firstLabel];
        
        _secondLabel = [[UILabel alloc]init];
        _secondLabel.backgroundColor = [UIColor clearColor];
        _secondLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:_secondLabel];
        
        _thirdLabel = [[UILabel alloc]init];
        _thirdLabel.backgroundColor = [UIColor clearColor];
        _thirdLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:_thirdLabel];
        
        _lastLabel = [[UILabel alloc]init];
        _lastLabel.backgroundColor = [UIColor clearColor];
        _lastLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:_lastLabel];
    }
    [self setupConstraints];
    return self;
}
- (void)setupConstraints
{
    static CGFloat leftMargin = 58;
    static CGFloat bottomMargin = -44;
    static CGFloat everyAdd = 50;
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_bottom).offset(bottomMargin);
        make.centerX.mas_equalTo(self.mas_left).offset(leftMargin);
    }];
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_bottom).offset(bottomMargin);
        make.centerX.mas_equalTo(self.mas_left).offset(leftMargin + everyAdd);
    }];
    [_thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_bottom).offset(bottomMargin);
        make.centerX.mas_equalTo(self.mas_left).offset(leftMargin + 2 * everyAdd);
    }];
    [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_bottom).offset(bottomMargin);
        make.centerX.mas_equalTo(self.mas_left).offset(leftMargin + 3 *everyAdd);
    }];
}
- (void)setDaysString:(NSString *)string
{
    NSString *newstring = [NSString stringWithFormat:@"0000%@",string];
    _firstLabel.text  = [newstring substringWithRange:NSMakeRange(newstring.length - 4, 1)];
    _secondLabel.text = [newstring substringWithRange:NSMakeRange(newstring.length - 3, 1)];
    _thirdLabel.text  = [newstring substringWithRange:NSMakeRange(newstring.length - 2, 1)];
    _lastLabel.text   = [newstring substringWithRange:NSMakeRange(newstring.length - 1, 1)];
    
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CheckInDaysView *view = [[CheckInDaysView alloc]initWithFrame:CGRectZero];
    CGRect frame = view.frame;
    frame.size = view.image.size;
    view.frame = frame;
    [view setDaysString:@"123"];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
