//
//  THEquipoCondicionTermicaViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoCondicionTermicaViewController.h"

@interface THEquipoCondicionTermicaViewController ()

@end

@implementation THEquipoCondicionTermicaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.equipoCondicionTermicaForm = [THEquipoCondicionTermicaForm new];
    self.formController.form = self.equipoCondicionTermicaForm;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guardarEquipoCondicionTermicaAction:(id)sender {
    
    self.equipoCondicionTermica.nombre = self.equipoCondicionTermicaForm.nombre;
    NSError *error = nil;
    if (![self.equipoCondicionTermica.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.delegate equipoCondicionTermincaFormViewController:self :self.equipoCondicionTermica];    
}

- (IBAction)cancelarEquipoCondicionTermicaAction:(id)sender {
    
    [self.equipoCondicionTermica.managedObjectContext deleteObject:self.equipoCondicionTermica];
    
    NSError *error = nil;
    if (![self.equipoCondicionTermica.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [self.delegate equipoCondicionTermincaFormViewController:self :nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
