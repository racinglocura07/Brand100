//
//  AgendaAdapter.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Dia.h"
#import "Actividad.h"
#import "Detalle.h"
#import "Auspiciantes.h"

#import "Utiles.h"

@interface AgendaAdapter : NSObject
@property (nonatomic,strong) Dia * Dia;

-(NSMutableArray *) leerInformacion:(NSString *) dir;
@end
