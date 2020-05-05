//
//  ArticleTableViewCell.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ArticleCellDelegate.h"
#import "Article+CoreDataProperties.h"
#import "ArticlePresenter.h"
#import "ArticleImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ArticleImageView *articleImgView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleDescription;
@property (weak, nonatomic) IBOutlet UILabel *articleAuthor;
@property (weak, nonatomic) IBOutlet UILabel *articleSource;
@property (weak, nonatomic) IBOutlet UILabel *articleTime;
@property (weak, nonatomic) IBOutlet UIButton *saveLtrBtn;
@property (nonatomic, weak) id <ArticleCellDelegate> delegate;
@property (nonatomic, weak) NSURLSessionDataTask* dataTask;

-(void)configure:(NSManagedObject*) value andImageCache:(NSCache*)imageFromCache;

@end

NS_ASSUME_NONNULL_END
