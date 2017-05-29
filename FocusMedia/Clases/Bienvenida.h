//
//  Bienvenida.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedNavigationController.h"
@interface Bienvenida : SharedNavigationController
@property (weak, nonatomic) IBOutlet UILabel *TituloBienvenida;

@property (weak, nonatomic) IBOutlet UITextView *TextoBienvenida;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenBienvenida;
@end
