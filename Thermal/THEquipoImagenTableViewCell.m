//
//  THEquipoImagenTableViewCell.m
//  Thermal
//
//  Created by David Almeciga on 2/7/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoImagenTableViewCell.h"

@implementation THEquipoImagenTableViewCell

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.equipoImagenCollectionView.dataSource = dataSourceDelegate;
    self.equipoImagenCollectionView.delegate = dataSourceDelegate;
    self.equipoImagenCollectionView.indexPath = indexPath;
    
    [self.equipoImagenCollectionView reloadData];
}

@end
