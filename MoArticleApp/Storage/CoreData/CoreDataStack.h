//
//  CoreDataStack.h
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStack : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
+ (id)sharedManager;

@end

NS_ASSUME_NONNULL_END
