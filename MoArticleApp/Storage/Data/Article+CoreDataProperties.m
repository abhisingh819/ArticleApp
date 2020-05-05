//
//  Article+CoreDataProperties.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//
//

#import "Article+CoreDataProperties.h"

@implementation Article (CoreDataProperties)

+ (NSFetchRequest<Article *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Article"];
}

@dynamic author;
@dynamic content;
@dynamic desc;
@dynamic publishedAt;
@dynamic source_id;
@dynamic source_name;
@dynamic title;
@dynamic url;
@dynamic urlToImage;
@dynamic webArchiveUrl;

@end
