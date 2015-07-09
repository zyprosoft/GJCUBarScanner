//
//  GJCUBarScannerLayer.m
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-11-1.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJCUBarScannerLayer.h"
#import "GJCFUitils.h"

@implementation GJCUBarScannerLayer

+ (GJCUBarScannerLayer *)layerWithSize:(CGSize)size
{
    GJCUBarScannerLayer *layer = [GJCUBarScannerLayer layer];
    
    UIColor *fromColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    
    UIImage *gradientImage = GJCFLinearGradientImageFromColorToColor(fromColor,GJCFQuickRGBColor(58,228,94),size);
    UIImage *gridMaskImage = GJCFGridImageByLineGapAndColorWithSize(3, [UIColor whiteColor], size);
    
    layer.backgroundColor = [[UIColor clearColor] CGColor];

    layer.frame = (CGRect){0,0,size.width,size.height};
    layer.contents= (__bridge id)[gradientImage CGImage];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = layer.bounds;
    maskLayer.contents = (__bridge id)[gridMaskImage CGImage];
    layer.mask = maskLayer;
    
    return layer;
}

@end
