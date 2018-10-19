//
//  SightsCollectionHeaderView.h
//  PublicArt
//
//  Created by Timur Sasin on 07/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightsCollectionViewController.h"

@interface SightsCollectionHeaderView : UICollectionReusableView

@property (strong, nonatomic) SightsCollectionViewController *controller;

- (IBAction)resetSearchResult:(UIButton *)sender;

@end
