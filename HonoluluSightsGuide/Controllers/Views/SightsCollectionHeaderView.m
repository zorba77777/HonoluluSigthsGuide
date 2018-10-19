//
//  SightsCollectionHeaderView.m
//  PublicArt
//
//  Created by Timur Sasin on 07/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "SightsCollectionHeaderView.h"

@implementation SightsCollectionHeaderView

- (IBAction)resetSearchResult:(UIButton *)sender {

    self.controller.sourceArray = self.controller.dataArray;
    [self.controller.collectionView reloadData];
}

@end
