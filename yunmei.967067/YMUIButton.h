//
//  YMUIButton.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-8.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface YMUIButton : NSObject


//根据三色生成CGColorRef
+(CGColorRef)CreateCGColorRef:(CGFloat)redNumer
                  greenNumber:(CGFloat)greenNumber
                   blueNumber:(CGFloat)blueNumber
                  alphaNumber:(CGFloat)alphaNumber;

//商品详情页的生成尺码button
+(UIButton *)CreateSizeButton:(NSString *)content
                      CGFrame:(CGRect)CGFrame;

//商品详情页根据颜色生成颜色按钮
+(UIButton *)CreateColorButton:(CGColorRef)refColor
                       CGFrame:(CGRect)CGFrame;

@end
