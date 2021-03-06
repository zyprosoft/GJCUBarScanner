//
//  GJCUBarScannerViewController.h
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-10-31.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJCUBarScannerViewControllerDelegate.h"
#import "GJCFUitils.h"
#import "UIView+GJCFViewFrameUitil.h"

@interface GJCUBarScannerViewController : UINavigationController

@property (nonatomic,weak)id<GJCUBarScannerViewControllerDelegate> scannerDelegate;

/**
 *  等待多长时间
 */
@property (nonatomic,assign)NSTimeInterval waitSeconds;


/**
 *  等待多长时间,最小10秒等待
 *
 *  @param seconds
 *
 *  @return
 */
- (id)initWithScanWaitSeconds:(NSTimeInterval)seconds;

@end
