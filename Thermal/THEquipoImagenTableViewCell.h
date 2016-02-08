//
//  THEquipoImagenTableViewCell.h
//  Thermal
//
//  Created by David Almeciga on 2/7/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THEquipoImagenCollectionView.h"

@interface THEquipoImagenTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet THEquipoImagenCollectionView *equipoImagenCollectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
