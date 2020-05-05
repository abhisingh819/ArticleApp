//
//  StorageManager.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface StorageManager : NSObject
-(void)saveToCoreData:(NSDictionary*) dict;
-(NSArray<NSManagedObject*>*)fetchAscending:(bool)ascending :(NSString*)filter;
- (void)updateRecord:(NSString*) url :(NSString*) webarchiveUrl;
- (void)deleteAll;

+ (id)sharedManager;
@end

NS_ASSUME_NONNULL_END
