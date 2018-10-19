//
//  ArtObjectMO+CoreDataProperties.h
//  
//
//  Created by Timur Sasin on 11/10/2018.
//
//  This file was automatically generated and should not be edited.
//

#import "ArtObjectMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ArtObjectMO (CoreDataProperties)

+ (NSFetchRequest<ArtObjectMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *access;
@property (nullable, nonatomic, copy) NSString *creator;
@property (nullable, nonatomic, copy) NSString *credit;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *descript;
@property (nullable, nonatomic, copy) NSString *discipline;
@property (nullable, nonatomic, copy) NSString *imagefile;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *objectid;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
