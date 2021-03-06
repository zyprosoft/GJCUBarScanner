//
//  GJCUBarScannerLayer.h
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-11-1.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GJCFUitils.h"
#import "UIView+GJCFViewFrameUitil.h"

@interface GJCUBarScannerLayer : CALayer

/**
 *  扫描动画Layer
 *
 *  @param size 扫描条的大小
 *
 *  @return
 */
+ (GJCUBarScannerLayer *)layerWithSize:(CGSize)size;

@end
