//
//  WebViewController.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/4/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webview;
@property (weak, nonatomic) NSString* urlToLoad;

@end

NS_ASSUME_NONNULL_END
