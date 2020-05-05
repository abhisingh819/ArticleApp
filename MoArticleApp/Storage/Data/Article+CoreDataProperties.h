//
//  Article+CoreDataProperties.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//
//

#import "Article+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Article (CoreDataProperties)

+ (NSFetchRequest<Article *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *author;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *desc;
@property (nullable, nonatomic, copy) NSDate *publishedAt;
@property (nullable, nonatomic, copy) NSString *source_id;
@property (nullable, nonatomic, copy) NSString *source_name;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *urlToImage;
@property (nullable, nonatomic, copy) NSString *webArchiveUrl;

@end

NS_ASSUME_NONNULL_END
