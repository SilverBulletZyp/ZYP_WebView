//
//  VC_02.m
//  ZYP_WebView
//
//  Created by 赵云鹏 on 2017/11/7.
//  Copyright © 2017年 赵云鹏. All rights reserved.
//

#import "VC_02.h"
#import <WebKit/WebKit.h>


@interface VC_02 () <WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *wk;
@property (nonatomic, strong) FBKVOController *kvo;
@end

@implementation VC_02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认配置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    // 默认偏好
    config.preferences = [[WKPreferences alloc]init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO; // 默认no不能自动通过窗口打开
    
    // web内容池
    config.processPool = [[WKProcessPool alloc]init];
    
    
    
    // 创建
    self.wk = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    self.wk.scrollView.backgroundColor = [UIColor redColor];
    self.wk.navigationDelegate = self; // 导航代理
    self.wk.UIDelegate = self;         // webview UI交互代理
    [self.view addSubview:self.wk];
    [self.wk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(120);
    }];
    
   

    
    
    // load
    NSURL *path = [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"html"];
    [self.wk loadRequest:[NSURLRequest requestWithURL:path]];
    
    
    
    
    NSLog(@"123");// po [[self view] recursiveDescription]
    
    /*
     
     [[UIWindow keyWindow] recursiveDescription] // 检查视图层级结构
     [[[UIWindow keyWindow] rootViewController] _printHierarchy] // 检查视图控制器
     
     <UIView: 0x7fd0d9204e10; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x60400003ce80>>
     | <WKWebView: 0x7fd0d7806e00; frame = (0 0; 0 0); layer = <CALayer: 0x6080002226a0>>
     |    | <WKScrollView: 0x7fd0d784f800; baseClass = UIScrollView; frame = (0 0; 0 0); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x608000243a50>; layer = <CALayer: 0x6080002219c0>; contentOffset: {0, 0}; contentSize: {0, 0}; adjustedContentInset: {0, 0, 0, 0}>
     |    |    | <WKContentView: 0x7fd0d7855600; frame = (0 0; 0 0); gestureRecognizers = <NSArray: 0x60000044db60>; layer = <CALayer: 0x608000222240>>
     |    |    |    | <UIView: 0x7fd0d640e9e0; frame = (0 0; 0 0); clipsToBounds = YES; layer = <CALayer: 0x600000430960>>
     |    |    |    |    | <UIView: 0x7fd0d6429e60; frame = (0 0; 0 0); autoresize = W+H; layer = <CALayer: 0x60000042f6a0>>
     |    |    | <UIView: 0x7fd0d642a270; frame = (0 0; 0 0); opaque = NO; layer = <CALayer: 0x600000430f40>>
     
     
     */
 
    
    
    
    // 监听
    self.kvo = [FBKVOController controllerWithObserver:self];
    
    
    __weak __typeof(self)weakSelf = self;
    [self.kvo observe:self.wk keyPath:@"loading"
              options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change)
     {
         __strong __typeof(weakSelf)strongSelf =  weakSelf;
         NSLog(@"change = %@",change);
         NSString *str = [NSString stringWithFormat:@"%@",[change objectForKey:@"new"]];
         if (!strongSelf.wk.loading) {//[str isEqualToString:@"0"]
             [strongSelf.wk evaluateJavaScript:@"test0()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                 NSLog(@"3333333");
             }];
         }
     }];
    
    [self.kvo observe:self.wk keyPath:@"title"
              options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change)
     {
         NSLog(@"change = %@",change);
     }];
    
    [self.kvo observe:self.wk keyPath:@"estimatedProgress"
              options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change)
     {
         NSLog(@"change = %@",change);
         
     }];
    
}



@end
