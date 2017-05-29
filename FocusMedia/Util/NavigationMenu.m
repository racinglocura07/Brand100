//
//  NavigationMenu.m
//  FocusMedia
//
//  Created by Administrador on 6/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "NavigationMenu.h"
#import "MenuItem.h"

@implementation NavigationMenu
{
    NSMutableArray * menuArray;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    menuArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    MenuItem * menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_home iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Home";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_info iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Bienvenida";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_map_marker iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Planos";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_calendar iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Agenda General";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_bookmark iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Agenda Personal";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_book iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Catálogo";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_rss iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Destacados";
    [menuArray addObject:menuItem];
    
    menuItem = [[MenuItem alloc] init];
    menuItem.Imagen = [FontAwesome imageWithIcon:fa_envelope iconColor:[UIColor grayColor] iconSize:25];
    menuItem.Titulo = @"Notificaciones";
    [menuArray addObject:menuItem];
    
    //NotificacionesCell
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 4 ){
        NSString * urlString = [self getAgendaPersonal ];
        NSURL *url = [NSURL URLWithString:urlString];
        
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItem * usar = [menuArray objectAtIndex:indexPath.row];
    
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%@Cell",[usar.Titulo stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = usar.Titulo;
    cell.imageView.image = usar.Imagen;
    return cell;
}

- (NSString *) getAgendaPersonal {
    Utiles * sharedManager = [Utiles sharedManager];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@", sharedManager.EventosUrl, @"Textos"] ofType:@"cfg"];
    
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    for (NSString * line in lines) {
        if ([line containsString:@"AgendaPersonal" ])
            return [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return @"";
}

@end
