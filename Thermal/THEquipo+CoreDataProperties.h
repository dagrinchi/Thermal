//
//  THEquipo+CoreDataProperties.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "THEquipo.h"

NS_ASSUME_NONNULL_BEGIN

@interface THEquipo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nombreEquipo;
@property (nullable, nonatomic, retain) NSString *ubicacion;
@property (nullable, nonatomic, retain) NSDate *creado;
@property (nullable, nonatomic, retain) THInstalacion *instalacion;
@property (nullable, nonatomic, retain) NSSet<THImagenNormal *> *imagenNormal;
@property (nullable, nonatomic, retain) NSSet<THImagenTermica *> *imagenTermica;
@property (nullable, nonatomic, retain) THEquipoCondicionTermica *condicionTermica;

@end

@interface THEquipo (CoreDataGeneratedAccessors)

- (void)addImagenNormalObject:(THImagenNormal *)value;
- (void)removeImagenNormalObject:(THImagenNormal *)value;
- (void)addImagenNormal:(NSSet<THImagenNormal *> *)values;
- (void)removeImagenNormal:(NSSet<THImagenNormal *> *)values;

- (void)addImagenTermicaObject:(THImagenTermica *)value;
- (void)removeImagenTermicaObject:(THImagenTermica *)value;
- (void)addImagenTermica:(NSSet<THImagenTermica *> *)values;
- (void)removeImagenTermica:(NSSet<THImagenTermica *> *)values;

@end

NS_ASSUME_NONNULL_END
