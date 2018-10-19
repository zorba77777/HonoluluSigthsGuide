//
//  AppDelegate.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 10/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

