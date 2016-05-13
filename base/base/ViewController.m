//
//  ViewController.m
//  base
//
//  Created by 沈雁飞 on 16/4/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <GLKit/GLKit.h>
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
CGAffineTransform CGAffineTransformMakeShear(CGFloat x,CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *viewArray;
@end

@implementation ViewController
{
//    CALayer *_layer;
//    
//    CALayer *_outLayer;
//    CALayer *_innerLayer;
    UIView  *_contentView;
}
-(NSMutableArray *)viewArray
{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}
- (void)addToViewArray
{
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc]init];
        view.size = CGSizeMake(200, 200);
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor greenColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 200, 200);
        label.font = [UIFont systemFontOfSize:40];
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        [view addSubview:label];
        [self.viewArray addObject:view];
    }
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.viewArray[index];
    [_contentView addSubview:face];
    //center the face view within the container
    CGSize containerSize = _contentView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    [self applyLightingToFace:face.layer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _contentView = [[UIView alloc]init];
    _contentView.size = CGSizeMake(100, 100);
    _contentView.center = self.view.center;
    [self.view addSubview:_contentView];
    
    [self addToViewArray];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    _contentView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    CGAffineTransform tranform = CGAffineTransformMakeRotation(PI(45));
//    _layer.affineTransform = tranform;
//    CGAffineTransform tranform = CGAffineTransformIdentity;
//    tranform = CGAffineTransformRotate(tranform, PI(45));
//    tranform = CGAffineTransformScale(tranform, 0.5, 0.5);
//    tranform = CGAffineTransformTranslate(tranform, 0, -300);
//    tranform = CGAffineTransformMakeShear(1, 0);
//    _layer.affineTransform = tranform;
//    CATransform3D transform = _layer.transform;
//    transform.m34 = -1.0 /500;
//    transform = CATransform3DMakeRotation(PI(180), 0, 1, 0);
//    _layer.transform = transform;
//    CATransform3D outer = CATransform3DMakeRotation(PI(45), 0, 1, 0);
//    _outLayer.transform = outer;
//    
//    CATransform3D inner = CATransform3DMakeRotation(PI(-45), 0, 1, 0);
//    _innerLayer.transform = inner;
    
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, PI(-45), 1, 0, 0);
    perspective = CATransform3DRotate(perspective, PI(-45), 0, 1, 0);
    _contentView.layer.sublayerTransform = perspective;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
