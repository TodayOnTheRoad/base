//
//  LogDefine.h
//  base
//
//  Created by 沈雁飞 on 16/5/31.
//  Copyright © 2016年 syf. All rights reserved.
//

#ifndef LogDefine_h
#define LogDefine_h


#endif /* LogDefine_h */



#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif



#define NSLog_Point(point)   NSLog(@"%@",NSStringFromCGPoint(point));
#define NSLog_Size(size)     NSLog(@"%@",NSStringFromCGSize(size));
#define NSLog_Rect(rect)     NSLog(@"%@",NSStringFromCGRect(rect));
#define NSLog_Insets(insets) NSLog(@"%@",NSStringFromUIEdgeInsets(insets));
#define NSLog_Offset(offset) NSLog(@"%@",NSStringFromUIOffset(offset));