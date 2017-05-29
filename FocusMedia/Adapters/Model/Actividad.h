//
//  Activiad.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Auspiciantes.h"
#import <Foundation/Foundation.h>

@interface Actividad : NSObject
@property (nonatomic,strong) NSString * Titulo;
@property (nonatomic,strong) NSString * Descripcion;
@property (nonatomic,strong) NSString * Horario;
@property (nonatomic,strong) Auspiciantes * Auspiciantes;
@property (nonatomic) NSMutableArray * Detalles;
@end
