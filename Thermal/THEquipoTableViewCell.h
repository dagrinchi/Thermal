//
//  THEquipoTableViewCell.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THEquipoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *equipoNombreLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipoUbicacionLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipoCondicionTermicaLabel;

@end
