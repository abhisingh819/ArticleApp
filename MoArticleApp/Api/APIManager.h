//
//  APIManager.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (id)sharedManager;

- (void)doGet:(NSString*) url andHeaders:(NSDictionary*) headers andCompletion:(void(^)(id, bool))callback;
- (NSURLSessionDataTask*)doGetImage:(NSString*) urlString andHeaders:(NSDictionary*) headers andCompletion:(void(^)(NSData*))callback;

@end

NS_ASSUME_NONNULL_END
