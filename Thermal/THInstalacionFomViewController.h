//
//  THInstalacionFomViewController.h
//  Thermal
//
//  Created by David Almeciga on 2/4/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "FXForms.h"
#import "THInstalacionForm.h"
#import "THInstalacion.h"

@protocol InstalacionAddDelegate;

@interface THInstalacionFomViewController : FXFormViewController

@property (nonatomic, strong) THInstalacion *instalacion;
@property (nonatomic, strong) THInstalacionForm *instalacionForm;
@property (nonatomic, unsafe_unretained) id <InstalacionAddDelegate> delegate;

@end

#pragma mark -

@protocol InstalacionAddDelegate <NSObject>

- (void)instalacionFormViewController:(THInstalacionFomViewController *)instalacionFormViewController :(THInstalacion *)instalacion;

@end
