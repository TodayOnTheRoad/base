//
//  UIView+Category.h
//  test
//
//  Created by 沈雁飞 on 16/2/5.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef NS_ENUM(NSInteger, ViewBorderLinetype) {
//    ViewBorderLinetypeNone   = 0,
//    ViewBorderLinetypeTop    = 1,
//    ViewBorderLinetypeLeft   = 2,
//    ViewBorderLinetypeBottom = 3,
//    ViewBorderLinetypeRight  = 4,
//};
@interface UIView (Category)
#pragma mark - size相关
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGSize size;

#pragma mark - 其他
/**
 *  给当前view设置部分圆角
 *
 *  @param cornerRadius 圆角半径
 *  @param corners      设置圆角的部分
 *  @注意此方法用自动布局的话，只能写在自定义view的LayoutSubviews 或者控制器的viewdidLayOutSubviews
 */
//- (void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;

//- (void)setBorderLineWithBorderLinetype:(ViewBorderLinetype)type;
@end
