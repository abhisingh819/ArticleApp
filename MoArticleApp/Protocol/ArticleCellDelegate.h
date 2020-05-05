//
//  ArticleCellDelegate.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/4/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ArticleCellDelegate <NSObject>

@required
- (void)saveArchiveUrl:(NSUInteger) tag;

@end

NS_ASSUME_NONNULL_END
