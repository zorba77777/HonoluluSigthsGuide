//
//  CoreDataHelper.m
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 13/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance
{
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HonoluluSightsGuide" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}
- (ArtObjectMO *)favoriteFromArtObject:(ArtObject *)artObject {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ArtObject"];
    request.predicate = [NSPredicate predicateWithFormat:@"objectid == %@", artObject.objectid];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(ArtObject *)artObject {
    return [self favoriteFromArtObject:artObject] != nil;
}

- (void)addToFavorite:(ArtObject *)artObject {
    ArtObjectMO * objectMO= [NSEntityDescription insertNewObjectForEntityForName:@"ArtObject" inManagedObjectContext:_managedObjectContext];
    objectMO.access = artObject.access;
    objectMO.creator = artObject.creator;
    objectMO.credit = artObject.credit;
    objectMO.date = artObject.date;
    objectMO.descript = artObject.descript;
    objectMO.discipline = artObject.discipline;
    objectMO.imagefile = artObject.imagefile;
    objectMO.latitude = artObject.latitude;
    objectMO.location = artObject.location;
    objectMO.longitude = artObject.longitude;
    objectMO.objectid = artObject.objectid;
    objectMO.title = artObject.title;
    [self save];
}

- (void)removeFromFavorite:(ArtObject *)artObject {
    ArtObjectMO *artObjectMO = [self favoriteFromArtObject:artObject];
    if (artObjectMO) {
        [_managedObjectContext deleteObject:artObjectMO];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ArtObject"];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}



@end
