//
//  CoreDataHelper.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 13/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArtObject.h"
#import "ArtObjectMO+CoreDataClass.h"
#import "ArtObjectMO+CoreDataProperties.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(ArtObject *)artObject;
- (NSArray *)favorites;
- (void)addToFavorite:(ArtObject *)artObject;
- (void)removeFromFavorite:(ArtObject *)artObject;

@end
