//
//  THInstalacionDetalleTableViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THInstalacionDetalleTableViewController.h"

@interface THInstalacionDetalleTableViewController () <UINavigationControllerDelegate, UITextFieldDelegate>


@property (assign) BOOL singleEdit;

@end

@implementation THInstalacionDetalleTableViewController

#define EQUIPOS_SECTION 0

static NSString *kAgregarEquipoSegueID = @"agregarEquipo";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.instalacionTituloTextField setText:self.instalacion.nombre];
    [self.instalacionCreadoLabel setText:[NSDateFormatter localizedStringFromDate:self.instalacion.creado
                                                                        dateStyle:NSDateFormatterShortStyle
                                                                        timeStyle:NSDateFormatterFullStyle]];
    

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creado" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    
    NSMutableArray *equiposOrdenados = [[NSMutableArray alloc] initWithArray:[self.instalacion.equipos allObjects]];
    [equiposOrdenados sortUsingDescriptors:sortDescriptors];
    self.equipos = equiposOrdenados;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case EQUIPOS_SECTION:
            title = @"Equipos";
            break;
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger rows = 0;
    
    switch (section) {
        case EQUIPOS_SECTION:
            rows = self.instalacion.equipos.count;
            if (self.editing) {
                rows++;
            }
            break;
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == EQUIPOS_SECTION) {
        NSUInteger equiposCount = self.instalacion.equipos.count;
        NSInteger row = indexPath.row;
        
        if (row < (NSInteger)equiposCount) {
            THEquipoTableViewCell *cell = (THEquipoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"equipoCell" forIndexPath:indexPath];
            THEquipo *equipo = [self.equipos objectAtIndex:row];
            
            [cell.equipoNombreLabel setText:equipo.nombreEquipo];
            [cell.equipoUbicacionLabel setText:equipo.ubicacion];
//            [cell.equipoCondicionTermicaLabel setText:equipo.condicionTermica.nombre];
            
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"agregarEquipoCell" forIndexPath:indexPath];
        }
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.section == EQUIPOS_SECTION)) {

        THEquipo *equipo = [self.equipos objectAtIndex:indexPath.row];
        [self.instalacion removeEquiposObject:equipo];
        [self.equipos removeObject:equipo];
        
        NSManagedObjectContext *context = equipo.managedObjectContext;
        [context deleteObject:equipo];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self performSegueWithIdentifier:kAgregarEquipoSegueID sender:self.instalacion];
    }

}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kAgregarEquipoSegueID]) {
        
        THInstalacion *instalacion = nil;
        
        if ([sender isKindOfClass:[THInstalacion class]]) {

            instalacion = (THInstalacion *)sender;

            UINavigationController *navController = (UINavigationController *) segue.destinationViewController;
            THEquipoFormViewController *equipoFormViewController = (THEquipoFormViewController *) navController.topViewController;
            equipoFormViewController.instalacion = instalacion;
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.singleEdit = YES;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.singleEdit = NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    
    if (indexPath.section == EQUIPOS_SECTION) {

        if (indexPath.row == (NSInteger)self.instalacion.equipos.count) {
            style = UITableViewCellEditingStyleInsert;
        }
        else {
            style = UITableViewCellEditingStyleDelete;
        }
    }
    
    return style;
}

- (THEquipo *)equipoByName:(NSString *)nombreEquipo {
    
    THEquipo *equipo = nil;
    NSArray *equipos = [self.instalacion.equipos allObjects];
    for (equipo in equipos) {
        if ([equipo.nombreEquipo isEqualToString:nombreEquipo])
            break;
    }
    return equipo;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
//    // If editing, don't allow instructions to be selected
//    // Not editing: Only allow instructions to be selected
//    //
    if ((isEditing && section == 2) || (!isEditing && section != 2)) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;
    }
    
    return rowToSelect;
}


#pragma mark -

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!self.singleEdit) {
        self.instalacionTituloTextField.enabled = editing;
        [self.navigationItem setHidesBackButton:editing animated:YES];
        
        [self.tableView beginUpdates];
        
        NSUInteger equiposCount = self.instalacion.equipos.count;
        NSArray *equiposInsertIndexPath = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:equiposCount inSection:EQUIPOS_SECTION], nil];
        
        if (editing) {
            [self.tableView insertRowsAtIndexPaths:equiposInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [self.tableView deleteRowsAtIndexPaths:equiposInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [self.tableView endUpdates];
    }
    
    if (!editing) {
        NSManagedObjectContext *context = self.instalacion.managedObjectContext;
        NSError *error = nil;
        if (![context save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == self.instalacionTituloTextField) {
        self.instalacion.nombre = self.instalacionTituloTextField.text;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Moving rows

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL canMove = NO;
    if (indexPath.section == EQUIPOS_SECTION) {
        canMove = indexPath.row != (NSInteger)self.instalacion.equipos.count;
    }
    return canMove;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    NSIndexPath *target = proposedDestinationIndexPath;
    
    NSUInteger proposedSection = proposedDestinationIndexPath.section;
    
    if (proposedSection < EQUIPOS_SECTION) {
        target = [NSIndexPath indexPathForRow:0 inSection:EQUIPOS_SECTION];
    } else if (proposedSection > EQUIPOS_SECTION) {
        target = [NSIndexPath indexPathForRow:(self.instalacion.equipos.count - 1) inSection:EQUIPOS_SECTION];
    } else {
        NSUInteger ingredientsCount_1 = self.instalacion.equipos.count - 1;
        
        if (proposedDestinationIndexPath.row > (NSInteger)ingredientsCount_1) {
            target = [NSIndexPath indexPathForRow:ingredientsCount_1 inSection:EQUIPOS_SECTION];
        }
    }
    
    return target;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    /*
     Update the ingredients array in response to the move.
     Update the display order indexes within the range of the move.
     */
    THEquipo *equipo = [self.equipos objectAtIndex:fromIndexPath.row];
    [self.equipos removeObjectAtIndex:fromIndexPath.row];
    [self.equipos insertObject:equipo atIndex:toIndexPath.row];
    
    NSInteger start = fromIndexPath.row;
    if (toIndexPath.row < start) {
        start = toIndexPath.row;
    }
    NSInteger end = toIndexPath.row;
    if (fromIndexPath.row > end) {
        end = fromIndexPath.row;
    }
    for (NSInteger i = start; i <= end; i++) {
        equipo = [self.equipos objectAtIndex:i];
        equipo.displayOrder = [NSNumber numberWithInteger:i];
    }
}


@end
