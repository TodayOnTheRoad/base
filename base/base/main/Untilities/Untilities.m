//
//  Untilities.m
//  photo
//
//  Created by 沈雁飞 on 16/2/24.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "Untilities.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@implementation Untilities
+ (instancetype)share
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
-(BOOL)canCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
        }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
@end
