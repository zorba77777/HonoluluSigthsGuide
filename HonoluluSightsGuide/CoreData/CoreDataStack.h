//
//  CoreDataStack.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 10/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ArtObject.h"
#import "ArtObjectMO+CoreDataClass.h"
#import "ArtObjectMO+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStack : NSObject

+ (instancetype)shared;

- (NSManagedObjectContext *)context;
- (NSManagedObject *)insertNewObjectToEntity:(NSString *)name;
- (void)deleteObject:(NSManagedObject *)object;
- (void)save;
- (NSManagedObject *)fetchObject:(NSString *)objectid;
- (ArtObjectMO *)fillArtObjectMOFromArtObject:(ArtObject *)artObject objectMO:(ArtObjectMO *)objectMO;
- (ArtObjectMO *)convertArtObjecttoArtObjectMO:(ArtObject *)artObject;
- (ArtObject *)convertArtObjectMOtoArtObject:(ArtObjectMO *)artObjectMO;

@end

NS_ASSUME_NONNULL_END
