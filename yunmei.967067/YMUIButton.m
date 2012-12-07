//
//  YMUIButton.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-8.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "YMUIButton.h"

@implementation YMUIButton

//生成商品详情页的尺码button
+(UIButton *)CreateSizeButton:(NSString *)content
                      CGFrame:(CGRect)CGFrame
{
    //生成尺寸的选择框按钮
    UIButton *chiBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮定位
    [chiBtn1 setFrame:CGFrame];
    //设置标题
    [chiBtn1 setTitle:content forState:UIControlStateNormal];
    //设置背景色
    [chiBtn1 setBackgroundColor:[UIColor whiteColor]];
    //设置字体颜色
    [chiBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置边框宽
    [chiBtn1.layer setBorderWidth:1.0];
    //生成button边框的颜色
    CGColorRef borderColor = [YMUIButton CreateCGColorRef:228 greenNumber:228 blueNumber:228 alphaNumber:1.0];
    [chiBtn1.layer setBorderColor:borderColor];
    return chiBtn1;
}

//生成商品详情页颜色button
+(UIButton *)CreateColorButton:(CGColorRef)refColor
                       CGFrame:(CGRect)CGFrame
{
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮定位
    [colorBtn setFrame:CGFrame];
    //生成按钮背景色
    [colorBtn setBackgroundColor:[UIColor colorWithCGColor:refColor]];
    //设置边逛宽度
    [colorBtn.layer setBorderWidth:4.0];
    //生成并设置边框颜色
    CGColorRef borderColor = [YMUIButton CreateCGColorRef:255 greenNumber:255 blueNumber:255 alphaNumber:1.0];
    [colorBtn.layer setBorderColor:borderColor];
    return colorBtn;
}

//根据三色生成CGColorRef
+(CGColorRef)CreateCGColorRef:(CGFloat)redNumer
                  greenNumber:(CGFloat)greenNumber
                   blueNumber:(CGFloat)blueNumber
                  alphaNumber:(CGFloat)alphaNumber
{
    CGFloat r = (CGFloat)redNumer/255.0;
    CGFloat g = (CGFloat)greenNumber/255.0;
    CGFloat b = (CGFloat)blueNumber/255.0;
    CGFloat a = (CGFloat)alphaNumber;
    CGFloat componets[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef CreatedCGColorRef = CGColorCreate(colorSpace, componets);
    return CreatedCGColorRef;
}

@end
