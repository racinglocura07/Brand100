//
//  Agenda.h
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "SharedNavigationController.h"

@interface Agenda : SharedNavigationController <UITableViewDataSource,UITableViewDelegate, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TablaAgenda;
@property (weak, nonatomic) IBOutlet UITabBar *AgendaTab;

@end
