//
//  THImagenViewController.m
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THImagenViewController.h"

@interface THImagenViewController ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation THImagenViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.imagenView setImage:self.imagen];
}

@end
