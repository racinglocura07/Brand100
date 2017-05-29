//
//  CatalogoAdapter.m
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "CatalogoAdapter.h"

@implementation CatalogoAdapter

-(NSMutableArray *) leerInformacion:(NSString *) dir {
    
    NSMutableArray * TodasEmpresas = [[NSMutableArray alloc] init];
    NSMutableArray* dirs = [Utiles getFiles:dir condition:nil];
    for (NSString * Dias in dirs) {
        NSString *layoutFiles = [NSString stringWithFormat:@"%@/%@", Dias, @"empresa.cfg"];
        [TodasEmpresas addObject:[self EmpresaEmpresa:layoutFiles]];
    }
    
    return TodasEmpresas;
}

-(Empresa *) EmpresaEmpresa:(NSString *) file {
    
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    
    Empresa * emp = [[Empresa alloc] init];
    emp.Asistentes =[[NSMutableArray alloc] init];
    
    for (int x= 0; x < lines.count; x++) {
        NSString * line = [lines objectAtIndex:x];
        
        if ( [line containsString:@"[-Empresa]"]){
            while(![line containsString:@"[Empresa-]"])
            {
                line = [lines objectAtIndex:x];
                if ([line containsString:@"="])
                {
                    NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    if ([Key isEqualToString:@"Nombre"])
                        emp.Nombre = Value;
                    if ([Key isEqualToString:@"Logo"])
                        emp.Logo = [NSString stringWithFormat:@"%@/%@", [file stringByDeletingLastPathComponent],Value];
                    if ([Key isEqualToString:@"Informacion"])
                        emp.Informacion = Value;
                    if ([Key isEqualToString:@"Novedades"])
                        emp.Novedades = Value;
                }
                if (![line containsString:@"[Empresa-]"])
                    x++;
            }
        }
        
        if ( [line containsString:@"[-Asistentes]"]){
            Asistentes * asis = [[Asistentes alloc] init];
            
            while(![line containsString:@"[Asistentes-]"])
            {
                line = [lines objectAtIndex:x];
                if ([line containsString:@"="])
                {
                    NSString * Key = [[line componentsSeparatedByString:@"="][0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString * Value = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    if ([Key isEqualToString:@"Imagen"]){
                        NSString * imagenes = [NSString stringWithFormat:@"%@/%@", [file stringByDeletingLastPathComponent],Value];
                        asis.Imagen = imagenes;
                    }
                    if ([Key isEqualToString:@"Nombre"])
                        asis.Nombre = Value;
                    if ([Key isEqualToString:@"Descripcion"])
                        asis.Descripcion = Value;
                }
                
                if (![line containsString:@"[Asistentes-]"])
                    x++;
            }
            [emp.Asistentes addObject:asis];
        }
        
        
        
    }
    
    return emp;
}

@end
