//
//  DataManager.h
//  PublicArt
//
//  Created by Timur Sasin on 30/09/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataManager : NSObject

+ (instancetype)shared;

-(void)loadData;

@property (nonatomic, strong, readonly) NSArray *artObjects;

@end

