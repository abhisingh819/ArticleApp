//
//  ArticlePresenter.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "ArticlePresenter.h"
#import "APIManager.h"

@implementation ArticlePresenter
    
__weak id<ArticleView> article;
APIManager* apiInterface;
StorageManager* storeInterface;
NSString* endpoint = @"https://moedemo-93e2e.firebaseapp.com/assignment/NewsApp/articles.json";

- (id)init :(id<ArticleView>) view {
    self = [super init];
    if(self){
        article = view;
        storeInterface = [StorageManager sharedManager];
        _filter = @"";
    }
    return self;
}

- (void)getAPIData {
    apiInterface = [APIManager sharedManager];
    [apiInterface doGet:endpoint andHeaders:[NSDictionary alloc] andCompletion:^(id json, bool error){
        if(error){
            [self getStorageData:false :Nil];
        }else {
            [self getStorageData:true :(NSDictionary *)json];
        }
    }];
    
}

- (void)getStorageData:(bool)saveData :(NSDictionary*)json {
    [storeInterface saveToCoreData:json];
    [self fetchAscending:NO];
}

- (void)fetchAscending:(bool)ascending {
    [article update:[storeInterface fetchAscending:ascending :self.filter]];
}

- (void)deleteAllRecords {
    [storeInterface deleteAll];
    [self getAPIData];
}

- (void)updateRecord:(NSString *) url :(NSString *) webarchiveUrl {
    [storeInterface updateRecord:url :webarchiveUrl];
    [self fetchAscending:NO];
}

- (void)addFilter:(NSString *)author {
    self.filter = author;
    [self. filter stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self fetchAscending:NO];
}

- (void)resetFilter {
    self.filter = @"";
    [self fetchAscending:NO];
}

- (NSString*) getStringFromUrl:(NSString*) url {
    NSURL *oURL = [NSURL URLWithString:url];

    NSError *error = nil;
    NSString *convertedHTMLString = [NSString stringWithContentsOfURL:oURL encoding: NSUTF8StringEncoding error:&error];

    if (error != nil)
    {
        return @"";
    }
    else
    {
        return convertedHTMLString;
    }
}

@end
