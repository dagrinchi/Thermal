//
//  THImagenViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THImagenViewController.h"

@interface THImagenViewController ()

@end

@implementation THImagenViewController

- (void)showAlert :(void (^)(UIAlertAction *action))onOkAction :(void (^)(UIAlertAction *action))onCancelAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Eliminar"
                                                                   message:@"¿Está seguro que desea eliminar?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:onOkAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:onCancelAction];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.imagenObj isKindOfClass:[THImagenNormal class]]) {
       [self.imagenView setImage:((THImagenNormal *) self.imagenObj).imagen];
    } else if ([self.imagenObj isKindOfClass:[THImagenTermica class]]) {
       [self.imagenView setImage:((THImagenTermica *) self.imagenObj).imagen];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=10.0;
}

- (IBAction)eliminarImagenAction:(id)sender {
    [self showAlert:^(UIAlertAction *action) {
        NSManagedObjectContext *context = self.imagenObj.managedObjectContext;
        [context deleteObject:self.imagenObj];
        
        NSError *error = nil;
        if (![context save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } :nil];
}

#pragma mark Scroll View Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imagenView;
}
@end
