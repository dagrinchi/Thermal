//
//  THInstalacionesTableViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/3/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THInstalacionesTableViewController.h"

@interface THInstalacionesTableViewController ()

@end

@implementation THInstalacionesTableViewController


static NSString *kVerInstalacionSegueID = @"verInstalacion";
static NSString *kAgregarInstalacionSegueID = @"agregarInstalacion";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)instalacionFormViewController:(THInstalacionFomViewController *)instalacionFormViewController :(THInstalacion *)instalacion
{
    if (instalacion) {
        [self performSegueWithIdentifier:kVerInstalacionSegueID sender:instalacion];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    NSInteger count = [self.fetchedResultsController sections].count;
    
    if (count == 0) {
        count = 1;
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger numberOfRows = 0;
    
    if ([self.fetchedResultsController sections].count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"instalacionCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    THInstalacion *instalacion = (THInstalacion *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:instalacion.nombre];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kVerInstalacionSegueID]) {
        
        THInstalacionDetalleTableViewController *instalacionDetalleViewController = (THInstalacionDetalleTableViewController *) segue.destinationViewController;
        
        THInstalacion *instalacion = nil;
        
        if ([sender isKindOfClass:[THInstalacion class]]) {
            instalacion = (THInstalacion *)sender;
        } else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            instalacion = (THInstalacion *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        }
        
        instalacionDetalleViewController.instalacion = instalacion;
    }
    else if ([segue.identifier isEqualToString:kAgregarInstalacionSegueID]) {
        THInstalacion *instalacion = [NSEntityDescription insertNewObjectForEntityForName:@"THInstalacion"
                                                          inManagedObjectContext:self.managedObjectContext];
        
        UINavigationController *navController = segue.destinationViewController;
        THInstalacionFomViewController *formController = (THInstalacionFomViewController *)navController.topViewController;
        formController.delegate = self;
        formController.instalacion = instalacion;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"THInstalacion" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creado" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
