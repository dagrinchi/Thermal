//
//  THImagenTransformer.m
//  Thermal
//
//  Created by David Almeciga on 2/8/16.
//  Copyright © 2016 mancoltda. All rights reserved.
//

#import "THImagenTransformer.h"

@implementation THImagenTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    NSData *data = UIImageJPEGRepresentation(value, 90);
    return data;
}

- (id)reverseTransformedValue:(id)value {
    UIImage *uiImage = [[UIImage alloc] initWithData:value];
    return uiImage;
}

@end
