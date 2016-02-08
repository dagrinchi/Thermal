//
//  THEquipoImagenTermicaTableViewCell.m
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoImagenTermicaTableViewCell.h"

@implementation THEquipoImagenTermicaTableViewCell

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.equipoImagenTermicaCollectionView.dataSource = dataSourceDelegate;
    self.equipoImagenTermicaCollectionView.delegate = dataSourceDelegate;
    self.equipoImagenTermicaCollectionView.indexPath = indexPath;
    
    [self.equipoImagenTermicaCollectionView reloadData];
}


@end
