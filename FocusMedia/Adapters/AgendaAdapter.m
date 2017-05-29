//
//  AgendaAdapter.m
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "AgendaAdapter.h"


@implementation AgendaAdapter
@synthesize Dia = dia;

-(NSMutableArray *) leerInformacion:(NSString *) dir {
    
    NSMutableArray * TodosDias = [[NSMutableArray alloc] init];
    NSMutableArray* dirs = [Utiles getFiles:dir condition:nil];
    for (NSString * Dias in dirs) {
        NSString *layoutFiles = [NSString stringWithFormat:@"%@/%@", Dias, @"layout.cfg"];
        [TodosDias addObject:[self DiaADia:layoutFiles]];
    }
    
    return TodosDias;
}

-(Dia *) DiaADia:(NSString *) file {
    
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    
    Dia * day = [[Dia alloc] init];
    day.Actividades =[[NSMutableArray alloc] init];
    day.Actividades =[[NSMutableArray alloc] init];
    
    for (int x= 0; x < lines.count; x++) {
        NSString * line = [lines objectAtIndex:x];
        
        if ( [line containsString:@"[-Titulo]"]){
            while(![line containsString:@"[Titulo-]"])
            {
                line = [lines objectAtIndex:x];
                if ([line containsString:@"="])
                {
                    NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    if ([Key isEqualToString:@"Dia"])
                        day.Dia = Value;
                    if ([Key isEqualToString:@"Fecha"])
                        day.Fecha = Value;
                }
                if (![line containsString:@"[Titulo-]"])
                    x++;
            }
        }
        
        if ( [line containsString:@"[-Actividad]"]){
            Actividad * acti = [[Actividad alloc] init];
            //acti.Auspiciantes = [[NSMutableArray alloc] init];
            acti.Detalles = [[NSMutableArray alloc] init];
            
            while(![line containsString:@"[Actividad-]"])
            {
                line = [lines objectAtIndex:x];
                if ([line containsString:@"="])
                {
                    NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    if ([Key isEqualToString:@"Titulo"])
                        acti.Titulo = Value;
                    if ([Key isEqualToString:@"Descripcion"])
                        acti.Descripcion = Value;
                    if ([Key isEqualToString:@"Horario"])
                        acti.Horario = Value;
                }
                
                if ( [line containsString:@"[-Auspiciante]"]){
                    Auspiciantes * auspi = [[Auspiciantes alloc] init];
                    while(![line containsString:@"[Auspiciante-]"])
                    {
                        line = [lines objectAtIndex:x];
                        if ([line containsString:@"="])
                        {
                            NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            
                            if ([Key isEqualToString:@"Titulo"])
                                auspi.Titulo = Value;
                            if ([Key isEqualToString:@"Imagen"])
                                auspi.Imagen = [NSString stringWithFormat:@"%@/%@", [file stringByDeletingLastPathComponent],Value];
                        }
                        if (![line containsString:@"[Auspiciante-]"])
                            x++;
                    }
                    acti.Auspiciantes = auspi;
                }
                
                if ( [line containsString:@"[-Detalle]"]){
                    Detalle * det = [[Detalle alloc] init];
                    while(![line containsString:@"[Detalle-]"])
                    {
                        line = [lines objectAtIndex:x];
                        if ([line containsString:@"="])
                        {
                            NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            
                            if ([Key isEqualToString:@"Titulo"])
                                det.Titulo = Value;
                            if ([Key isEqualToString:@"SubTitulo"])
                                det.SubTitulo = Value;
                            if ([Key isEqualToString:@"Imagenes"]){
                                
                                det.Imagenes = [[NSMutableArray alloc] init];
                                NSArray * sinRuta = [NSMutableArray arrayWithArray:[Value componentsSeparatedByString:@","]];
                                for (NSString * imagen in sinRuta) {
                                    NSString *usar = [imagen stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                    [det.Imagenes addObject:[NSString stringWithFormat:@"%@/%@", [file stringByDeletingLastPathComponent],usar]];
                                }
                                
                            }
                            if ([Key isEqualToString:@"Descripcion"])
                                det.Descripcion = Value;
                            if ([Key isEqualToString:@"Horario"])
                                det.Horario = Value;
                            
                        }
                        if (![line containsString:@"[Detalle-]"])
                            x++;
                    }
                    [acti.Detalles addObject:det];
                }
                
                if (![line containsString:@"[Actividad-]"])
                    x++;
            }
            [day.Actividades addObject:acti];
        }
        
        
        
    }
    
    return day;
}


@end

