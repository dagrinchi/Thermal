//
//  THEquipoFormViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoFormViewController.h"

@interface THEquipoFormViewController ()

@end

@implementation THEquipoFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.equipoForm = [THEquipoForm new];
    self.formController.form = self.equipoForm;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)cancelarEquipoAction:(id)sender {

    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)guardarEquipoAction:(id)sender {

    NSManagedObjectContext *context = [self.instalacion managedObjectContext];
    
    if (!self.equipo) {
        self.equipo = [NSEntityDescription insertNewObjectForEntityForName:@"THEquipo"
                                                        inManagedObjectContext:context];
        [self.instalacion addEquiposObject:self.equipo];
        self.equipo.displayOrder = [NSNumber numberWithInteger:self.instalacion.equipos.count];
    }
    
    self.equipo.nombreEquipo = self.equipoForm.nombre;
    self.equipo.ubicacion = self.equipoForm.ubicacion;
    self.equipo.condicionTermica = self.equipoForm.equipoCondicionTermica;
    self.equipo.creado = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
