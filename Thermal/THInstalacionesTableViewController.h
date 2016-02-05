//
//  THInstalacionesTableViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/3/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THInstalacionFomViewController.h"
#import "THInstalacionDetalleTableViewController.h"

@interface THInstalacionesTableViewController : UITableViewController <InstalacionAddDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
