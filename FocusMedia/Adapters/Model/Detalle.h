//
//  Detalle.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detalle : NSObject
@property (nonatomic,strong) NSString * Titulo;
@property (nonatomic,strong) NSString * SubTitulo;
@property (nonatomic,strong) NSMutableArray * Imagenes;
@property (nonatomic,strong) NSString * Descripcion;
@property (nonatomic,strong) NSString * Horario;
@end
