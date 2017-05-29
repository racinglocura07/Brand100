//
//  CatalogoNovedades.h
//  FocusMedia
//
//  Created by Administrador on 19/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Empresa.h"

@interface CatalogoNovedades : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NovedadesLabel;
@property (weak, nonatomic) IBOutlet UILabel *NoveAPresenarLabel;

@property (weak, nonatomic) Empresa * emp;
@end
