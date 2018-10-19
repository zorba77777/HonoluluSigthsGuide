//
//  ArtObjectMO+CoreDataProperties.m
//  
//
//  Created by Timur Sasin on 11/10/2018.
//
//  This file was automatically generated and should not be edited.
//

#import "ArtObjectMO+CoreDataProperties.h"

@implementation ArtObjectMO (CoreDataProperties)

+ (NSFetchRequest<ArtObjectMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ArtObject"];
}

@dynamic access;
@dynamic creator;
@dynamic credit;
@dynamic date;
@dynamic descript;
@dynamic discipline;
@dynamic imagefile;
@dynamic latitude;
@dynamic location;
@dynamic longitude;
@dynamic objectid;
@dynamic title;

@end
