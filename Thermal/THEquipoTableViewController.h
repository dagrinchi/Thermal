//
//  THEquipoTableViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/6/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "THEquipo.h"
#import "THEquipoCondicionTermica.h"
#import "THImagenNormal.h"
#import "THImagenTermica.h"

#import "THEquipoImagenTableViewCell.h"
#import "THEquipoImagenCollectionView.h"
#import "THEquipoImagenCollectionViewCell.h"

#import "THEquipoImagenTermicaTableViewCell.h"
#import "THEquipoImagenTermicaCollectionView.h"
#import "THEquipoImagenTermicaCollectionViewCell.h"

#import "THEditarEquipoCondicionTermicaTableViewController.h"
#import "THImagenViewController.h"

@interface THEquipoTableViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) THEquipo *equipo;
@property (nonatomic, strong) NSMutableArray *imagenesNormales;
@property (nonatomic, strong) NSMutableArray *imagenesTermicas;

@property (strong, nonatomic) IBOutlet UITextField *equipoNombreTextField;
@property (strong, nonatomic) IBOutlet UITextField *equipoUbicacionTextField;
@property (strong, nonatomic) IBOutlet UIButton *equipoCondicionTermicaButton;
@property (strong, nonatomic) IBOutlet UILabel *equipoCreadoLabel;

@end
