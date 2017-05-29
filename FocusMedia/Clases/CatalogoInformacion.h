//
//  CatalogoInformacion.h
//  FocusMedia
//
//  Created by Administrador on 19/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Empresa.h"

@interface CatalogoInformacion : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;
@property (weak, nonatomic) IBOutlet UITextView *Info;

@property (weak, nonatomic) Empresa * emp;
@end
