//
//  ArticleView.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ArticleView <NSObject>

@required 
- (void) update :(NSArray<NSManagedObject*> *) article;

@end

NS_ASSUME_NONNULL_END
