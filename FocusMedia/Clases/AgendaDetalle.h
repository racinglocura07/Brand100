//
//  AgendaDetalle.h
//  FocusMedia
//
//  Created by Administrador on 10/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detalle.h"

@interface AgendaDetalle : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BotonAtras;
@property (nonatomic,strong) NSMutableArray * ListaDetalle;

@property (weak, nonatomic) IBOutlet UITableView *TablaDetalle;

@end
