//
//  Catalogo.h
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "SharedNavigationController.h"

@interface Catalogo : SharedNavigationController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TablaCatalogo;

@end
