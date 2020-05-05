//
//  APIManager.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (id)sharedManager {
    static APIManager *sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApiManager = [[self alloc] init];
    });
    return sharedApiManager;
}

- (id)init {
  if (self = [super init]) {
  }
  return self;
}

/*
 doGet - to get json from server
 @parameters url(NSString*)
 @parameters headers(NSDictionary*)
 @parameters completionBlock(id, bool)
 return void
 */

- (void)doGet:(NSString*) url andHeaders:(NSDictionary*) headers andCompletion:(void(^)(id, bool))callback {
    
    NSLog(@"api called:");
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if(httpResponse.statusCode == 200)
      {
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        //NSLog(@"The response is - %@",responseDictionary);
          callback(responseDictionary, false);
      }
      else
      {
          NSLog(@"Error");
          callback(Nil, true);
      }
    }];
    [dataTask resume];
    
}

/*
doGetImage - to get image data from server
@parameters url(NSString*)
@parameters headers(NSDictionary*)
@parameters completionBlock(NSData*)
return NSURLSessionDataTask*
*/

- (NSURLSessionDataTask*)doGetImage:(NSString*) urlString andHeaders:(NSDictionary*) headers andCompletion:(void(^)(NSData*))callback {
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
        if(error != nil){
            NSLog(@"%@",error);
            callback(nil);
            return;
        }
        
        callback(data);
        
    }];
    [dataTask resume];
    return dataTask;
}

- (void)dealloc {
  // Should never be called, but just here for clarity really.
}

@end
