//
//  DetalleCell.h
//  FocusMedia
//
//  Created by Administrador on 10/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TituloDetalle;
@property (weak, nonatomic) IBOutlet UIImageView *ImagenesDetalle;
@property (weak, nonatomic) IBOutlet UILabel *DescripcionDetalle;
@property (weak, nonatomic) IBOutlet UILabel *SubTituloDetalle;
@property (weak, nonatomic) IBOutlet UIStackView *Container;

@end
