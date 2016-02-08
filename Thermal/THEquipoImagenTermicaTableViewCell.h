//
//  THEquipoImagenTermicaTableViewCell.h
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THEquipoImagenTermicaCollectionView.h"

@interface THEquipoImagenTermicaTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet THEquipoImagenTermicaCollectionView *equipoImagenTermicaCollectionView;


- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
