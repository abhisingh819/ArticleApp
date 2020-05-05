//
//  ArticlePresenter.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleView.h"
#import "APIManager.h"
#import "StorageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticlePresenter : NSObject

@property (weak,nonatomic) NSString* filter;

- (id)init :(id<ArticleView>) view;
- (void)getAPIData;
- (void)fetchAscending:(bool)ascending;
- (void)deleteAllRecords;
- (void)updateRecord:(NSString *) url :(NSString *) webarchiveUrl;
- (NSString*) getStringFromUrl:(NSString*) url;
- (void)addFilter:(NSString*) author;
- (void)resetFilter;

@end

NS_ASSUME_NONNULL_END
