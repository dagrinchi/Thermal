//
//  THEquipoCondicionTermicaForm.m
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THEquipoCondicionTermicaForm.h"

@implementation THEquipoCondicionTermicaForm

- (NSDictionary *)getField :(NSString *) key
{
    for (NSDictionary *obj in self.fields) {
        if ([obj objectForKey:@"key"] == key){
            return obj;
        }
    }
    
    return nil;
}

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"nombre",
               FXFormFieldTitle: @"Condición térmica",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}


@end
