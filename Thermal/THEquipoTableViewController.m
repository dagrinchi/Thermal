//
//  THEquipoTableViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/6/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoTableViewController.h"

@interface THEquipoTableViewController ()

@property (assign) BOOL singleEdit;
@property (assign) NSInteger currentSelectedSection;

@end

@implementation THEquipoTableViewController

#define IMAGEN_NORMAL_SECTION 0
#define IMAGEN_TERMICA_SECTION 1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    THEquipoCondicionTermica *equipoCondicionTermica = self.equipo.condicionTermica;
    
    [self.equipoNombreTextField setText:self.equipo.nombreEquipo];
    [self.equipoUbicacionTextField setText:self.equipo.ubicacion];
    [self.equipoCondicionTermicaButton setTitle:equipoCondicionTermica.nombre forState:UIControlStateNormal];
    [self.equipoCreadoLabel setText:[NSDateFormatter localizedStringFromDate:self.equipo.creado
                                                                   dateStyle:NSDateFormatterShortStyle
                                                                   timeStyle:NSDateFormatterShortStyle]];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creado" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    
    NSMutableArray *imagenesNormalesOrdenadas = [[NSMutableArray alloc] initWithArray:[self.equipo.imagenNormal allObjects]];
    [imagenesNormalesOrdenadas sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *imagenesTermicasOrdenadas = [[NSMutableArray alloc] initWithArray:[self.equipo.imagenTermica allObjects]];
    [imagenesTermicasOrdenadas sortUsingDescriptors:sortDescriptors];
    
    self.imagenesNormales = imagenesNormalesOrdenadas;
    self.imagenesTermicas = imagenesTermicasOrdenadas;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case IMAGEN_NORMAL_SECTION:
            title = @"Imágenes";
            break;
        case IMAGEN_TERMICA_SECTION:
            title = @"Imágenes térmicas";
            break;
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    switch (section) {
        case IMAGEN_NORMAL_SECTION:
            if (self.editing) {
                rows += 2;
            }
            break;
        case IMAGEN_TERMICA_SECTION:
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
    
    NSString *kCellIdentifier = nil;
    NSInteger row = indexPath.row;
    
    switch (indexPath.section) {
        case IMAGEN_NORMAL_SECTION:
            
            if (row == 0) {
                kCellIdentifier = @"imagenNormalCell";
            } else if (row == 1) {
                kCellIdentifier = @"agregarImagenNormalCell";
            } else if (row == 2) {
                kCellIdentifier = @"tomarImagenNormalCell";
            }
            
            break;
        case IMAGEN_TERMICA_SECTION:
            
            if (row < 1) {
                kCellIdentifier = @"imagenTermicaCell";
            } else {
                kCellIdentifier = @"agregarImagenTermicaCell";
            }
            
            break;
        default:
            break;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (indexPath.section) {
        case IMAGEN_NORMAL_SECTION:
            
            if (row == 0) {
                THEquipoImagenTableViewCell *equipoImagenTableViewCell = (THEquipoImagenTableViewCell *)cell;
                [equipoImagenTableViewCell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
            }
            
            break;
        case IMAGEN_TERMICA_SECTION:
            
            if (row == 0) {
                THEquipoImagenTermicaTableViewCell *equipoImagenTermicaTableViewCell = (THEquipoImagenTermicaTableViewCell *)cell;
                [equipoImagenTermicaTableViewCell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
            }
            
            break;
        default:
            break;
    }
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100;
    if ((indexPath.row == 1) || (indexPath.row == 2)) {
        height = 50;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.singleEdit = YES;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.singleEdit = NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        
        switch (indexPath.section) {
            case IMAGEN_NORMAL_SECTION:
                if (indexPath.row == 1) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                } else if (indexPath.row == 2) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                
                break;
            case IMAGEN_TERMICA_SECTION:
                if (indexPath.row == 1) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                
                break;
                
            default:
                break;
        }
        
        self.currentSelectedSection = indexPath.section;
        [self presentViewController:imagePicker animated:YES completion:nil];

    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    
    if ((indexPath.row == 1) || (indexPath.row == 2)) {
        style = UITableViewCellEditingStyleInsert;
    }
    
    return style;
}

#pragma mark -

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!self.singleEdit) {
        self.equipoNombreTextField.enabled = editing;
        self.equipoUbicacionTextField.enabled = editing;
        self.equipoCondicionTermicaButton.enabled = editing;
        
        [self.navigationItem setHidesBackButton:editing animated:YES];
        
        [self.tableView beginUpdates];
        
        NSArray *imagenNormalInsertIndexPath = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:IMAGEN_NORMAL_SECTION], [NSIndexPath indexPathForRow:2 inSection:IMAGEN_NORMAL_SECTION], nil];
        
        NSArray *imagenTermicaInsertIndexPath = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:IMAGEN_TERMICA_SECTION], nil];
        
        if (editing) {
            [self.tableView insertRowsAtIndexPaths:imagenNormalInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView insertRowsAtIndexPaths:imagenTermicaInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [self.tableView deleteRowsAtIndexPaths:imagenNormalInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView deleteRowsAtIndexPaths:imagenTermicaInsertIndexPath withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [self.tableView endUpdates];
    }
    
    if (!editing) {
        NSManagedObjectContext *context = self.equipo.managedObjectContext;
        NSError *error = nil;
        if (![context save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == self.equipoNombreTextField) {
        self.equipo.nombreEquipo = self.equipoNombreTextField.text;
    } else if (textField == self.equipoUbicacionTextField) {
        self.equipo.ubicacion = self.equipoUbicacionTextField.text;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
    
    NSManagedObject *imagenObj = nil;
    
    if (self.currentSelectedSection == IMAGEN_NORMAL_SECTION) {
        
        THImagenNormal *imagenNormal =
        (THImagenNormal *)[NSEntityDescription insertNewObjectForEntityForName:@"THImagenNormal"
                                                        inManagedObjectContext:self.equipo.managedObjectContext];
        imagenNormal.creado = [NSDate date];
        [self.equipo addImagenNormalObject:imagenNormal];
        imagenObj = imagenNormal;
        
    } else if (self.currentSelectedSection == IMAGEN_TERMICA_SECTION) {
        
        THImagenTermica *imagenTermica =
        (THImagenTermica *)[NSEntityDescription insertNewObjectForEntityForName:@"THImagenTermica"
                                                         inManagedObjectContext:self.equipo.managedObjectContext];
        imagenTermica.creado = [NSDate date];
        [self.equipo addImagenTermicaObject:imagenTermica];
        imagenObj = imagenTermica;
    }
    
    [imagenObj setValue:selectedImage forKey:@"imagen"];
    NSError *error = nil;
    if (![self.equipo.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Collection View Data Source

-(NSInteger)collectionView:(THEquipoImagenCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSIndexPath *indexPath = collectionView.indexPath;
    NSInteger row = indexPath.row;
    NSInteger count = 0;
    
    switch (indexPath.section) {
        case IMAGEN_NORMAL_SECTION:
            
            if (row == 0) {
                count = self.imagenesNormales.count;
            }
            
            break;
        case IMAGEN_TERMICA_SECTION:
            
            if (row == 0) {
                count = self.imagenesTermicas.count;
            }
            
            break;
        default:
            break;
    }
    
    return count;
}

-(UICollectionViewCell *)collectionView:(id)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    NSIndexPath *tableViewIndexPath = nil;
    NSInteger row = 0;
    
    if ([collectionView isKindOfClass:[THEquipoImagenCollectionView class]]) {
        
        THEquipoImagenCollectionView *equipoImagenCollectionView = (THEquipoImagenCollectionView *)collectionView;
        tableViewIndexPath = equipoImagenCollectionView.indexPath;
        row = tableViewIndexPath.row;
        
    } else if ([collectionView isKindOfClass:[THEquipoImagenTermicaCollectionView class]]) {
        
        THEquipoImagenTermicaCollectionView *equipoImagenTermicaCollectionView = (THEquipoImagenTermicaCollectionView *)collectionView;
        tableViewIndexPath = equipoImagenTermicaCollectionView.indexPath;
        row = tableViewIndexPath.row;
        
    }
    
    switch (tableViewIndexPath.section) {
        case IMAGEN_NORMAL_SECTION:
            
            if (row == 0) {
                THEquipoImagenCollectionViewCell *equipoImagenCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagenCollectionViewCell" forIndexPath:indexPath];
                THImagenNormal *imagenNormal = [self.imagenesNormales objectAtIndex:indexPath.item];
                [equipoImagenCollectionViewCell.imagen setImage:imagenNormal.imagen];
                cell = equipoImagenCollectionViewCell;
            }
            
            break;
        case IMAGEN_TERMICA_SECTION:
            
            if (row == 0) {
                THEquipoImagenCollectionViewCell *equipoImagenTermicaCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagenTermicaCollectionViewCell" forIndexPath:indexPath];
                THImagenTermica *imagenTermica = [self.imagenesTermicas objectAtIndex:indexPath.item];
                [equipoImagenTermicaCollectionViewCell.imagen setImage:imagenTermica.imagen];
                cell = equipoImagenTermicaCollectionViewCell;
            }
            
            break;
        default:
            break;
    }

    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"verImagenNormal"]) {

        THImagenViewController *imagenNormalViewController = segue.destinationViewController;
        THEquipoImagenCollectionViewCell *equipoImagenCollectionViewCell = (THEquipoImagenCollectionViewCell *)sender;
        imagenNormalViewController.imagen = equipoImagenCollectionViewCell.imagen.image;
    } else if ([segue.identifier isEqualToString:@"verImagenTermica"]) {
        
        THImagenViewController *imagenTermicaViewController = segue.destinationViewController;
        THEquipoImagenTermicaCollectionViewCell *equipoImagenTermicaCollectionViewCell = (THEquipoImagenTermicaCollectionViewCell *)sender;
        imagenTermicaViewController.imagen = equipoImagenTermicaCollectionViewCell.imagen.image;
    } else if ([segue.identifier isEqualToString:@"cambiarCondicionTermica"]) {
        
        THEditarEquipoCondicionTermicaTableViewController *editarCondicionTermicaTableViewController = segue.destinationViewController;
        editarCondicionTermicaTableViewController.equipo = self.equipo;
    }
}

@end
