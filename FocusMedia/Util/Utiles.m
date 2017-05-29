//
//  Utiles.m
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utiles.h"

@implementation Utiles
@synthesize HomeUrl;
@synthesize BienvenidaUrl;
@synthesize AgendaUrl;
@synthesize CatalogoUrl;
@synthesize EventosUrl;
@synthesize PlanosUrl;
@synthesize VersionUrl;
@synthesize PublicidadesUrl;
@synthesize TodoDescargado;
@synthesize RutaDescarga;

+ (id)sharedManager {
    static Utiles *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition aImagen:(BOOL)aImagen conExtension:(BOOL)conExtension {
    
    NSString * resourcePath = [NSString stringWithFormat:@"%@", dir];
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath
                                                                        error:nil];
    NSMutableArray * mutableReturn = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
  
        
        if ( condition == nil && aImagen)
            [mutableReturn addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@", resourcePath, filename]]];
        else if (condition == nil && !aImagen)
            if ( !conExtension )
                [mutableReturn addObject:[filename stringByDeletingPathExtension]];
            else
                [mutableReturn addObject:[NSString stringWithFormat:@"%@%@", resourcePath, filename]];
        else if ( condition != nil && aImagen){
            if ( [condition containsString:@"."] ? [filename hasSuffix:condition] : [filename hasPrefix:condition]){
                [mutableReturn addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@", resourcePath, filename]]];
            }
        }
        else if ( condition != nil && !aImagen )
        {
            if ( [condition containsString:@"."] ? [filename hasSuffix:condition] : [filename hasPrefix:condition]){
                if ( !conExtension )
                    [mutableReturn addObject:[filename stringByDeletingPathExtension]];
                else
                    [mutableReturn addObject:[NSString stringWithFormat:@"%@%@", resourcePath, filename]];
            }
        }
    }];
    
    return mutableReturn;
}

+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition {
    return [self getFiles:dir condition:condition aImagen:false conExtension:true];
}

+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition aImagen:(BOOL)aImagen {
    return [self getFiles:dir condition:condition aImagen:aImagen conExtension:false];
}

+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition conExtension:(BOOL)conExtension {
    return [self getFiles:dir condition:condition aImagen:false conExtension:conExtension];
}

+ (NSMutableArray *) getDirs:(NSString *)dir{
    
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir
                                                                        error:NULL];
    NSMutableArray *mutar = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        [mutar addObject:filename];
    }];
    
    return mutar;
}

- (id)init {
    if (self = [super init]) {
        TodoDescargado = NO;
        
        HomeUrl = @"Recursos/Home/";
        BienvenidaUrl = @"Recursos/Bienvenida/";
        AgendaUrl = @"Recursos/Agenda/";
        CatalogoUrl = @"Recursos/Catalogo/";
        EventosUrl = @"Recursos/Eventos/";
        PlanosUrl = @"Recursos/Planos/";
        VersionUrl = @"Recursos/version";
        PublicidadesUrl = @"Recursos/Publicidades/";
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString * docPath = [[documentsDirectoryURL path] stringByAppendingString:@"/"];
        
        RutaDescarga = docPath;
        
    
        TodoDescargado = [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:HomeUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:BienvenidaUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:AgendaUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:CatalogoUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:EventosUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:PlanosUrl]]
        && [[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingString:PublicidadesUrl]];
        
        NSLog(@"Todo descargado? = %@", TodoDescargado ? @"Si!" : @"No");
            
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
