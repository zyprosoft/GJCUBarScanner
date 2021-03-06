//
//  GJCUBarScannerViewControllerDelegate.h
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-11-1.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GJCUBarScannerViewController;
@protocol GJCUBarScannerViewControllerDelegate <NSObject>

@required

/**
 *  成功扫码回调
 *
 *  @param scanner
 *  @param resultBarString 扫码结果json字符串
 */
- (void)barScanner:(GJCUBarScannerViewController *)scanner didSuccessScannerWithResult:(NSString *)resultBarString;

/**
 *  将要退出
 *
 *  @param scanner
 */
- (void)barScannerWillCancel:(GJCUBarScannerViewController *)scanner;

/**
 *  将要显示
 *
 *  @param scanner
 */
- (void)barScannerWillShow:(GJCUBarScannerViewController *)scanner;

/**
 *  无权访问相机导致失败
 *
 *  @param scanner
 */
- (void)barScannerDidFaildByNoAuthorizeCamera:(GJCUBarScannerViewController *)scanner;

/**
 *  等候太长时间导致失败
 *
 *  @param scanner
 */
- (void)barScannerDidFaildByTooLongTimeScannedNothing:(GJCUBarScannerViewController *)scanner;

@end