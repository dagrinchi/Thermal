//
//  THEquipoForm.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoForm.h"

@implementation THEquipoForm

- (NSDictionary *)getField :(NSString *) key
{
    for (NSDictionary *obj in self.fields) {
        if ([obj objectForKey:@"key"] == key){
            return obj;
        }
    }
    
    return nil;
}

- (NSString *)equipoCondicionTermicaFieldDescription
{
    return self.equipoCondicionTermica ? self.equipoCondicionTermica.nombre : nil;
}

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"nombre",
               FXFormFieldTitle: @"Nombre",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"ubicacion",
               FXFormFieldTitle: @"Ubicación",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"equipoCondicionTermica",
               FXFormFieldTitle: @"Condición térmica",
               FXFormFieldViewController: @"THEquipoCondicionTermicaTableViewController",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}


@end
