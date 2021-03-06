//
//  GJCUBarScannerViewController.m
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-10-31.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJCUBarScannerViewController.h"
#import "GJCUBarScannerDetailViewController.h"
#import "GJCFUitils.h"


@interface GJCUBarScannerViewController ()

@property (nonatomic,strong)GJCUBarScannerDetailViewController *scanner;

@property (nonatomic,assign)BOOL dismissing;

@end

@implementation GJCUBarScannerViewController

- (instancetype)initWithScanWaitSeconds:(NSTimeInterval)seconds
{
    if (self = [super init]) {
        
        self.waitSeconds = seconds;
        [self initScannerWithWaitSeconds:seconds];
        
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        [self initScannerWithWaitSeconds:0];
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self initScannerWithWaitSeconds:0];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        [self initScannerWithWaitSeconds:0];
    }
    return self;
}

- (void)dealloc
{
    [GJCFNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    
    if (!GJCFAppCanAccessCamera) {
        if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScannerDidFaildByNoAuthorizeCamera:)]) {
            [self.scannerDelegate barScannerDidFaildByNoAuthorizeCamera:self];
        }
    }
}

- (void)setupNavigationBar
{
    NSString *bunldePath = GJCFMainBundlePath(@"GJCUBarScannerResourceBundle.bundle");
    NSString *bundleImagePath = GJCFBundlePath(bunldePath,@"GjImageBrowser_Navigation_bar_back.png");
    UIImage *navImage = GJCFQuickImageByFilePath(bundleImagePath);
    
    [self.navigationBar setBackgroundImage:GJCFImageStrecth(navImage, 3, 3) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScannerWillShow:)]) {
        [self.scannerDelegate barScannerWillShow:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScannerWillCancel:)]) {
        [self.scannerDelegate barScannerWillCancel:self];
    }
}

#pragma mark - 初始化

- (void)initScannerWithWaitSeconds:(NSTimeInterval)seconds
{
    self.scanner = [[GJCUBarScannerDetailViewController alloc]init];
    self.scanner.waitSeconds = seconds;
    [self setViewControllers:@[self.scanner] animated:NO];

    [self observeScanner];
    
}


#pragma mark - 观察扫描结果

- (void)observeScanner
{
    [GJCFNotificationCenter addObserver:self selector:@selector(successScannResult:) name:GJCUBarScannerDetailViewControllerDidFinishScannerNoti object:nil];
    [GJCFNotificationCenter addObserver:self selector:@selector(faildByTooLongTimeNoResult:) name:GJCUBarScannerDetailViewControllerDidFaildByTooLongTimeNoResultNoti object:nil];
    [GJCFNotificationCenter addObserver:self selector:@selector(cancelNoti:) name:GJCUBarScannerDetailViewControllerDidFaildChooseCancelNoti object:nil];
}

- (void)cancelNoti:(NSNotification *)noti
{
    /* 否则出现重复视图动画混乱 */
    if (self.dismissing) {
        return;
    }
    self.dismissing = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)successScannResult:(NSNotification *)noti
{
    /* 否则出现重复视图动画混乱 */
    if (self.dismissing) {
        return;
    }
    self.dismissing = YES;
    
    if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScanner:didSuccessScannerWithResult:)]) {
        [self.scannerDelegate barScanner:self didSuccessScannerWithResult:noti.object];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)faildByTooLongTimeNoResult:(NSNotification *)noti
{
    if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScannerDidFaildByTooLongTimeScannedNothing:)]) {
        [self.scannerDelegate barScannerDidFaildByTooLongTimeScannedNothing:self];
    }
}

- (void)faildByNotAuthorizeCamera:(NSNotification *)noti
{
    if (self.scannerDelegate && [self.scannerDelegate respondsToSelector:@selector(barScannerDidFaildByNoAuthorizeCamera:)]) {
        [self.scannerDelegate barScannerDidFaildByNoAuthorizeCamera:self];
    }
}


@end
