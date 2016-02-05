//
//  THInstalacionForm.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms/FXForms.h>
#import "THInstalacion.h"

@interface THInstalacionForm : NSObject <FXForm>

@property (nonatomic, strong) NSString *nombre;

- (NSDictionary *)getField :(NSString *) key;

@end
