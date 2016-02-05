//
//  THInstalacionDetalleTableViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THInstalacion.h"
#import "THEquipo.h"
#import "THEquipoCondicionTermica.h"
#import "THEquipoTableViewCell.h"
#import "THEquipoFormViewController.h"

@interface THInstalacionDetalleTableViewController : UITableViewController

@property (nonatomic, strong) THInstalacion *instalacion;
@property (nonatomic, strong) NSMutableArray *equipos;

@property (strong, nonatomic) IBOutlet UITextField *instalacionTituloTextField;
@property (strong, nonatomic) IBOutlet UILabel *instalacionCreadoLabel;


@end
