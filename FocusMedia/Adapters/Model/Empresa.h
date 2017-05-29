//
//  Empresa.h
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Empresa : NSObject
@property(nonatomic,strong) NSString * Nombre;
@property(nonatomic,strong) NSString * Logo;
@property(nonatomic,strong) NSString * Informacion;
@property(nonatomic,strong) NSString * Novedades;
@property(nonatomic,strong) NSMutableArray * Asistentes;
@end
