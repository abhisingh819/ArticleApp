//
//  CoreDataManager.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

- (void)save:(NSDictionary *)dict {
    CoreDataStack* core = [CoreDataStack sharedManager];
    NSManagedObjectContext* context = core.persistentContainer.viewContext;
    NSArray* array = [self isExist:[dict objectForKey:@"url"]];
    if([array count] == 0){
        NSManagedObject* article = [NSEntityDescription
        insertNewObjectForEntityForName:@"Article"
        inManagedObjectContext:context];
        [self setArticleData:article dictionary:dict];
        NSError *error;
        [context save:&error];
    }
    
    
}


- (NSArray<NSManagedObject *> *)fetch:(bool)ascending :(NSString*)filter{
    
    CoreDataStack* core = [CoreDataStack sharedManager];
    NSManagedObjectContext* context = core.persistentContainer.viewContext;
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Article"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    if(![filter isEqualToString:@""] && filter != nil) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"author contains[c] %@", filter];
        [request setPredicate:predicate];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"publishedAt" ascending:ascending];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request
    error:&error];
    return array;
}

-(void)deleteFromCoreData {
    
    CoreDataStack* core = [CoreDataStack sharedManager];
    NSManagedObjectContext* context = core.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
    }
}



- (void)setArticleData:(NSManagedObject*) article dictionary:(NSDictionary*) aDict {
    if([aDict objectForKey:@"title"] == [NSNull null]) {
        [article setValue:@"" forKey:@"title"];
    } else {
        [article setValue:[aDict objectForKey:@"title"] forKey:@"title"];
    }
    if([aDict objectForKey:@"description"] == [NSNull null]) {
        [article setValue:@"" forKey:@"desc"];
    } else {
        [article setValue:[aDict objectForKey:@"description"] forKey:@"desc"];
    }
    if([aDict valueForKeyPath:@"source.id"] == [NSNull null]) {
        [article setValue:@"" forKey:@"source_id"];
    } else {
        [article setValue:[aDict valueForKeyPath:@"source.id"] forKey:@"source_id"];
    }
    if([aDict valueForKeyPath:@"source.name"] == [NSNull null]) {
        [article setValue:@"" forKey:@"source_name"];
    } else {
        [article setValue:[aDict valueForKeyPath:@"source.name"] forKey:@"source_name"];
    }
    if([aDict objectForKey:@"author"] == [NSNull null]) {
        [article setValue:@"" forKey:@"author"];
    } else {
        [article setValue:[aDict objectForKey:@"author"] forKey:@"author"];
    }
    if([aDict objectForKey:@"url"] == [NSNull null]) {
        [article setValue:@"" forKey:@"url"];
    } else {
        [article setValue:[aDict objectForKey:@"url"] forKey:@"url"];
    }
    if([aDict objectForKey:@"urlToImage"] == [NSNull null]) {
        [article setValue:@"" forKey:@"urlToImage"];
    } else {
        [article setValue:[aDict objectForKey:@"urlToImage"] forKey:@"urlToImage"];
    }
    [article setValue:@"" forKey:@"webArchiveUrl"];
    [article setValue:[self getDate:[aDict objectForKey:@"publishedAt"]] forKey:@"publishedAt"];
}


- (NSDate*)getDate:(NSString*) stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    return [dateFormatter dateFromString:stringDate];
}

- (NSArray *)isExist:(NSString*) url {
    CoreDataStack* core = [CoreDataStack sharedManager];
    NSManagedObjectContext* context = core.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@",url];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *arrResult = [context executeFetchRequest:fetchRequest error:&error];
    return arrResult;
}

- (void)update:(NSString*)url :(NSString*) webArchiveUrl{
    CoreDataStack* core = [CoreDataStack sharedManager];
    NSManagedObjectContext* context = core.persistentContainer.viewContext;
    NSArray* array = [self isExist:url];
    if([array count] > 0){
        Article* article = [array objectAtIndex:0];
        article.webArchiveUrl = webArchiveUrl;
        NSError *error;
        [context save:&error];
    }
}



@end
