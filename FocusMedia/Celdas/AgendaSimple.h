//
//  AgendaSimple.h
//  FocusMedia
//
//  Created by Administrador on 21/4/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaSimple : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Titulo;
@property (weak, nonatomic) IBOutlet UILabel *Descripcion;
@property (weak, nonatomic) IBOutlet UILabel *Horario;
@property (weak, nonatomic) IBOutlet UILabel *Auspiciante;

@property (weak, nonatomic) IBOutlet UIImageView *AuspicianteImagen;
@end
