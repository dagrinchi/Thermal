//
//  THEquipoCondicionTermicaViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "FXForms.h"
#import "THEquipoCondicionTermicaForm.h"
#import "THEquipoCondicionTermica.h"

@protocol EquipoCondicionTermicaAddDelegate;

@interface THEquipoCondicionTermicaViewController : FXFormViewController

@property (nonatomic, strong) THEquipoCondicionTermicaForm *equipoCondicionTermicaForm;
@property (nonatomic, strong) THEquipoCondicionTermica *equipoCondicionTermica;
@property (nonatomic, unsafe_unretained) id <EquipoCondicionTermicaAddDelegate> delegate;

@end

#pragma mark -

@protocol EquipoCondicionTermicaAddDelegate <NSObject>

- (void)equipoCondicionTermincaFormViewController:(THEquipoCondicionTermicaViewController *)equipoCondicionTermincaFormViewController :(THEquipoCondicionTermica *)equipoCondicionTermica;

@end