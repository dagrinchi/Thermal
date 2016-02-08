//
//  THEditarEquipoCondicionTermicaTableViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THEquipo.h"
#import "THEquipoCondicionTermica.h"
#import "AppDelegate.h"

@interface THEditarEquipoCondicionTermicaTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) THEquipo *equipo;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
