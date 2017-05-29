//
//  BajarYDescomprimir.h
//  FocusMedia
//
//  Created by Administrador on 20/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BajarYDescomprimir : NSObject
@property (nonatomic,strong) NSMutableData * receivedData;
-(void) BajarArchivo:(NSString *)ruta;
@end
