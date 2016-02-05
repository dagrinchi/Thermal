//
//  THImagenNormal+CoreDataProperties.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "THImagenNormal.h"

NS_ASSUME_NONNULL_BEGIN

@interface THImagenNormal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *creado;
@property (nullable, nonatomic, retain) id imagen;
@property (nullable, nonatomic, retain) THEquipo *equipo;

@end

NS_ASSUME_NONNULL_END
