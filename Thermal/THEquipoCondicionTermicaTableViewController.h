//
//  THEquipoCondicionTermicaTableViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THEquipoCondicionTermica.h"
#import "THEquipoCondicionTermicaViewController.h"
#import "AppDelegate.h"

@interface THEquipoCondicionTermicaTableViewController : UITableViewController <EquipoCondicionTermicaAddDelegate, FXFormFieldViewController, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) FXFormField *field;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
