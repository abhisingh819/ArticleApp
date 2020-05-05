//
//  StorageManager.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/2/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "StorageManager.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@implementation StorageManager

+ (id)sharedManager {
    static StorageManager *sharedStorageManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStorageManager = [[self alloc] init];
    });
    return sharedStorageManager;
}

- (id)init {
  if (self = [super init]) {
  }
  return self;
}

//Core Data Manager methods

- (void)saveToCoreData:(NSDictionary *)dict {
    CoreDataManager* coreManager = [CoreDataManager new];
    NSArray* array = [NSArray arrayWithArray:[dict objectForKey:@"articles"]];
    for(NSDictionary *aDict in array)
    {
        [coreManager save:aDict];
    }
}

- (NSArray<NSManagedObject *> *)fetchAscending:(bool)ascending :(NSString*)filter {
    return [[CoreDataManager new] fetch:ascending :filter];
}

- (void)deleteAll {
    [[CoreDataManager new] deleteFromCoreData];
}

- (void)updateRecord:(NSString*) url :(NSString*) webarchiveUrl {
    [[CoreDataManager new] update:url :webarchiveUrl];
}

- (void)dealloc {
  // Should never be called, but just here for clarity really.
}

@end
