//
//  AgendaCell.h
//  FocusMedia
//
//  Created by Administrador on 8/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Horario;
@property (weak, nonatomic) IBOutlet UILabel *Titulo;
@property (weak, nonatomic) IBOutlet UILabel *SubTitulo;
@property (weak, nonatomic) IBOutlet UILabel *TituloAuspiciante;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenAuspi;
@property (weak, nonatomic) IBOutlet UIButton *BotonDetalle;

@end
