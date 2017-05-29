//
//  CatalogoAdapter.h
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Empresa.h"
#import "Asistentes.h"

#import "Utiles.h"

@interface CatalogoAdapter : NSObject
-(NSMutableArray *) leerInformacion:(NSString *) dir;
@end
