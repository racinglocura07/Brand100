//
//  Notificaciones.h
//  FocusMedia
//
//  Created by Julian on 5/30/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "SharedNavigationController.h"

@interface Notificaciones : SharedNavigationController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *TablaNotificaciones;
@end
