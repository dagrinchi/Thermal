//
//  THEquipo.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class THEquipoCondicionTermica, THImagenNormal, THImagenTermica, THInstalacion;

NS_ASSUME_NONNULL_BEGIN

@interface THEquipo : NSManagedObject

@property (nonatomic, strong) NSNumber *displayOrder;

@end

NS_ASSUME_NONNULL_END

#import "THEquipo+CoreDataProperties.h"
