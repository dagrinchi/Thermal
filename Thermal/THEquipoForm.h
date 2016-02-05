//
//  THEquipoForm.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms/FXForms.h>
#import "THEquipoCondicionTermica.h"

@interface THEquipoForm : NSObject <FXForm>

@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *ubicacion;
@property (nonatomic, strong) THEquipoCondicionTermica *equipoCondicionTermica;

- (NSDictionary *)getField :(NSString *) key;


@end
