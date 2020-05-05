//
//  CoreDataManager.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article+CoreDataProperties.h"
#import "CoreDataStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

- (void)save:(NSDictionary *) dict;
- (NSArray<NSManagedObject*>*)fetch:(bool) ascending :(NSString*)filter;
- (void)deleteFromCoreData;
- (void)update:(NSString*)url :(NSString*) webArchiveUrl;

@end

NS_ASSUME_NONNULL_END
