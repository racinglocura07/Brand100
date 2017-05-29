//
//  Utiles.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utiles : NSObject{
    NSString * HomeUrl;
    NSString *  BienvenidaUrl;
    NSString *  AgendaUrl;
    NSString * CatalogoUrl;
    NSString * EventosUrl;
    NSString * PlanosUrl;
    NSString * VersionUrl;
    NSString * PublicidadesUrl;
    
    NSString * RutaDescarga;
    
    BOOL TodoDescargado;
}

@property (nonatomic, retain) NSString *HomeUrl;
@property (nonatomic, retain) NSString *BienvenidaUrl;
@property (nonatomic, retain) NSString *AgendaUrl;
@property (nonatomic, retain) NSString *CatalogoUrl;
@property (nonatomic, retain) NSString *EventosUrl;
@property (nonatomic, retain) NSString *PlanosUrl;
@property (nonatomic, retain) NSString *VersionUrl;
@property (nonatomic, retain) NSString *PublicidadesUrl;

@property (nonatomic, retain) NSString *RutaDescarga;

@property (nonatomic) BOOL TodoDescargado;

+ (id)sharedManager;

+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition;
+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition aImagen:(BOOL)aImagen;
+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition conExtension:(BOOL)conExtension;
+ (NSMutableArray *) getFiles:(NSString *)dir condition:(NSString *)condition aImagen:(BOOL)aImagen conExtension:(BOOL)conExtension;

+ (NSMutableArray *) getDirs:(NSString *)dir;
@end
