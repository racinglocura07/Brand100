//
//  Home.h
//  FocusMedia
//
//  Created by Administrador on 5/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "SharedNavigationController.h"
#import <UIKit/UIKit.h>

@interface Home : SharedNavigationController
@property (weak, nonatomic) IBOutlet UIImageView *ImagenEvento;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenSponsor;

@property (weak, nonatomic) IBOutlet UILabel *FechaEvento;
@property (weak, nonatomic) IBOutlet UILabel *LugarEvento;

@property (weak, nonatomic) IBOutlet UIImageView *Carousel;
@property (weak, nonatomic) IBOutlet UILabel *InfoEvento;

+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (NSString *) traerColor;
@end
