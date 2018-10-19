//
//  CoreDataStack.m
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 10/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@end

@implementation CoreDataStack

+ (instancetype)shared {
    static CoreDataStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [CoreDataStack new];
        [stack setup];
    });
    
    return stack;
}

- (NSManagedObjectContext *)context {
    return _persistentContainer.viewContext;
}

- (void)setup {
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"HonoluluSightsGuide"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError * error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
}

- (NSManagedObject *)insertNewObjectToEntity:(NSString *)name {
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.context];
}

- (void)deleteObject:(NSManagedObject *)object {
    [self.context deleteObject:object];
    [self save];
}

- (void)save {
    NSError *error;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Failed to save Core Data context");
        abort();
    }
}

- (NSManagedObject *)fetchObject:(NSString *)objectid {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ArtObject"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"objectid == %@", objectid];
    
    NSArray *arr = [[CoreDataStack.shared context] executeFetchRequest:request error:nil];
    
    return [arr firstObject];
}

- (ArtObject *)convertArtObjectMOtoArtObject:(ArtObjectMO *)artObjectMO {
    
    ArtObject *object = [[ArtObject alloc] init];
    
    object.access = artObjectMO.access;
    object.creator = artObjectMO.creator;
    object.credit = artObjectMO.credit;
    object.date = artObjectMO.date;
    object.descript = artObjectMO.descript;
    object.discipline = artObjectMO.discipline;
    object.imagefile = artObjectMO.imagefile;
    object.latitude = artObjectMO.latitude;
    object.location = artObjectMO.location;
    object.longitude = artObjectMO.longitude;
    object.objectid = artObjectMO.objectid;
    object.title = artObjectMO.title;

    return object;
}

- (ArtObjectMO *)convertArtObjecttoArtObjectMO:(ArtObject *)artObject {
    
    ArtObjectMO *objectMO = [[ArtObjectMO alloc] init];
    
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
    
    return objectMO;
}



- (ArtObjectMO *)fillArtObjectMOFromArtObject:(ArtObject *)artObject objectMO:(ArtObjectMO *)objectMO {
    
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
    
    return objectMO;
}


@end

