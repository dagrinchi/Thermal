//
//  THEquipoFormViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "FXForms.h"
#import "THInstalacion.h"
#import "THEquipo.h"
#import "THEquipoForm.h"

@interface THEquipoFormViewController : FXFormViewController

@property (nonatomic, strong) THInstalacion *instalacion;
@property (nonatomic, strong) THEquipo *equipo;

@property (nonatomic, strong) THEquipoForm *equipoForm;

@end