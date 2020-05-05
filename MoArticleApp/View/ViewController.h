//
//  ViewController.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleView.h"
#import "ArticlePresenter.h"
#import "ArticleCellDelegate.h"
#import "WebViewController.h"

@interface ViewController : UIViewController<ArticleView, UITableViewDataSource, UITableViewDelegate, ArticleCellDelegate>

@property (strong, nonatomic) ArticlePresenter* viewPresenter;

@end

