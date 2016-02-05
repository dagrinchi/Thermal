//
//  THInstalacionFomViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THInstalacionFomViewController.h"

@interface THInstalacionFomViewController ()

@end

@implementation THInstalacionFomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Nueva instalación";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.instalacionForm = [THInstalacionForm new];
    self.formController.form = self.instalacionForm;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -


- (IBAction)guardarInstalacion:(id)sender {

    self.instalacion.nombre = self.instalacionForm.nombre;
    self.instalacion.creado = [NSDate date];
    
    NSError *error = nil;
    if (![self.instalacion.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [self.delegate instalacionFormViewController:self :self.instalacion];
}

- (IBAction)cancelarInstalacion:(id)sender {
    
    [self.instalacion.managedObjectContext deleteObject:self.instalacion];
    
    NSError *error = nil;
    if (![self.instalacion.managedObjectContext save:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.delegate instalacionFormViewController:self :nil];
}

@end
