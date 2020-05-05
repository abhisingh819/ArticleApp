//
//  ArticleImageView.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/4/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleImageView : UIImageView

@property (weak, nonatomic) NSString* imageUrlString;

- (NSURLSessionDataTask*)loadImageUsingUrlString:(NSString*) urlString :(NSCache*) imageFromCache;

@end

NS_ASSUME_NONNULL_END
