//
//  ArticleImageView.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/4/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "ArticleImageView.h"

@implementation ArticleImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (NSURLSessionDataTask*)loadImageUsingUrlString:(NSString*) urlString :(NSCache*) imageFromCache {
    self.imageUrlString = urlString;
    
    self.image = nil;
    
    if([imageFromCache objectForKey:urlString] != nil) {
        [self loadImage:urlString :imageFromCache];
        return nil;
    }
    
    APIManager* api = [APIManager sharedManager];
    return [api doGetImage:urlString andHeaders:[NSDictionary alloc] andCompletion:^(NSData* data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage* imageToCache = [UIImage imageWithData:data];
            if(imageToCache != nil) {
                [imageFromCache setObject:imageToCache forKey:urlString];
                if([self.imageUrlString isEqualToString:urlString]){
                    
                    [self loadImage:urlString :imageFromCache];
                }
            }
        });
        
    }];
    
    
    
}

-(void)loadImage:(NSString*)urlString :(NSCache*)imageFromCache{
    
    self.image = (UIImage*)[imageFromCache objectForKey:urlString];
    
}

@end
