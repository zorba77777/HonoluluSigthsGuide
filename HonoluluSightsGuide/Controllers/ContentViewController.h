//
//  ContentViewController.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 14/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int index;

@end

