//
//  THEquipoCondicionTermica+CoreDataProperties.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "THEquipoCondicionTermica.h"

NS_ASSUME_NONNULL_BEGIN

@interface THEquipoCondicionTermica (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nombre;
@property (nullable, nonatomic, retain) NSSet<THEquipo *> *equipos;

@end

@interface THEquipoCondicionTermica (CoreDataGeneratedAccessors)

- (void)addEquiposObject:(THEquipo *)value;
- (void)removeEquiposObject:(THEquipo *)value;
- (void)addEquipos:(NSSet<THEquipo *> *)values;
- (void)removeEquipos:(NSSet<THEquipo *> *)values;

@end

NS_ASSUME_NONNULL_END
