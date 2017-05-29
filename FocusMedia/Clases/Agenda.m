//
//  Agenda.m
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "AgendaCell.h"
#import "Agenda.h"
#import "AgendaDetalle.h"
#import "AgendaAdapter.h"
#import "AgendaSimple.h"

@interface Agenda ()
@property (nonatomic,strong) NSMutableArray * agendaArray;
@property (nonatomic) NSInteger diaActual;
@end

@implementation Agenda
@synthesize agendaArray;
//static NSString *simpleTableIdentifier = @"AgendaSimpleId";
static NSString *simpleTableIdentifier = @"ActividadesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Utiles * sharedManager = [Utiles sharedManager];
    AgendaAdapter *adapter = [[AgendaAdapter alloc] init];
    
    NSString * ruta =[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sharedManager.AgendaUrl ];
    if (sharedManager.TodoDescargado){
        ruta =[NSString stringWithFormat:@"%@%@", sharedManager.RutaDescarga,sharedManager.AgendaUrl];
    }
    
    agendaArray = [adapter leerInformacion:ruta];
    
    NSMutableArray *tbItems = [NSMutableArray arrayWithArray:[self.AgendaTab items]];
    for ( int i = 0; i < agendaArray.count; i++ ) // NSString * plano in imagenesPlanos)
    {
        Dia * day = [agendaArray objectAtIndex:i];
        
        UITabBarItem *localTabBarItem = [[UITabBarItem alloc] initWithTitle:day.Dia image:[FontAwesome imageWithIcon:fa_calendar iconColor:[UIColor blueColor] iconSize:20] tag:i];
        [tbItems addObject:localTabBarItem];
        
    }
    [self.AgendaTab setItems:tbItems];
    _diaActual = 0;
    [self.AgendaTab setSelectedItem:[self.AgendaTab.items objectAtIndex:_diaActual]];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static AgendaCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [self.TablaAgenda dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    CGFloat total = [cell.Titulo systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    total += [cell.SubTitulo systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    
    if ( cell.ImagenAuspi.tag == 1 )
        total += [cell.ImagenAuspi systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    if ( cell.TituloAuspiciante.tag == 1 )
        total += [cell.TituloAuspiciante systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    
    
//    static AgendaSimple *cell = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgendaSimple" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    });
//    
//    [self setupCell:cell atIndexPath:indexPath];
//    [cell layoutIfNeeded];
//    [cell updateConstraintsIfNeeded];
//    
//    CGFloat total = [cell.Titulo systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
//    total += [cell.Descripcion systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
//    
//    if ( cell.Horario.tag != 1 )
//        total += [cell.Horario systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
//    
//    if ( cell.Auspiciante.tag != 1)
//        total += [cell.Auspiciante systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
//    if ( cell.AuspicianteImagen.tag != 1 )
//        total += 140;
    
    return total + 50; //.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Dia * actual = [agendaArray objectAtIndex:_diaActual];
    return [actual.Actividades count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    AgendaSimple *cell = (AgendaSimple *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AgendaSimple" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//        
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
//    
//    [self setupCell:cell atIndexPath:indexPath];
//    
//    return cell;
    
    AgendaCell *cell = [self.TablaAgenda dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[AgendaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    //cell.textLabel.text = @"Prueba";
    return cell;
}

//-(void) setupCell:(AgendaSimple * )cell atIndexPath:(NSIndexPath *)indexPath{
//    Dia * actual = [agendaArray objectAtIndex:_diaActual];
//    Actividad * act = [actual.Actividades objectAtIndex:indexPath.row];
//    
//    NSString * titulo = act.Titulo;
//    NSString * descripcion = act.Descripcion;
//    NSString * horario = act.Horario;
//    
//    cell.Titulo.text = [Header convertHtmlPlainText:titulo];
//    
//    if ( descripcion != nil )
//        cell.Descripcion.text = [Header convertHtmlPlainText:descripcion];
//    else
//        cell.Descripcion.hidden = true;
//    
//    if ( horario != nil ){
//        cell.Horario.text = [Header convertHtmlPlainText:horario];
//        cell.Horario.tag = 0;
//    }
//    else{
//        cell.Horario.hidden = true;
//        cell.Horario.tag = 1;
//    }
//    
//    if ( act.Auspiciantes != nil ){
//        cell.Auspiciante.text = act.Auspiciantes.Titulo;
//        
//        NSString * aupiImg =act.Auspiciantes.Imagen;
//        cell.AuspicianteImagen.image =  [UIImage imageNamed:aupiImg];
//        cell.Auspiciante.tag = 0;
//        cell.AuspicianteImagen.tag = 0;
//    }
//    else{
//        cell.Auspiciante.hidden = true;
//        cell.Auspiciante.tag = 1;
//        cell.AuspicianteImagen.hidden = true;
//        cell.AuspicianteImagen.tag = 1;
//    }
//    
//    if (act.Detalles.count > 0 ){
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//}


- (void)setUpCell:(AgendaCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Dia * actual = [agendaArray objectAtIndex:_diaActual];
    Actividad * act = [actual.Actividades objectAtIndex:indexPath.row];
    
    if ( act.Descripcion == nil )
    for (Detalle *det in act.Detalles) {
        if (act.Descripcion == nil)
            act.Descripcion = [NSString stringWithFormat:@"*%@", det.Titulo];
        else
            act.Descripcion = [NSString stringWithFormat:@"%@\n*%@", act.Descripcion, det.Titulo];
    }
    
    cell.Horario.text = [Header convertHtmlPlainText:act.Horario];
    cell.Titulo.text = [Header convertHtmlPlainText:act.Titulo];
    cell.SubTitulo.text = [Header convertHtmlPlainText:act.Descripcion];
    
    cell.TituloAuspiciante.tag = 0;
    cell.TituloAuspiciante.hidden = true;
    cell.ImagenAuspi.hidden = true;
    if ( act.Auspiciantes != nil){
        cell.ImagenAuspi.image = [UIImage imageNamed:act.Auspiciantes.Imagen];
        cell.ImagenAuspi.hidden = false;
        if ( act.Auspiciantes.Titulo != nil){
            cell.TituloAuspiciante.text = act.Auspiciantes.Titulo;
            cell.TituloAuspiciante.tag = 1;
            cell.TituloAuspiciante.hidden = false;
        }
    }
    
    cell.ImagenAuspi.tag = act.Auspiciantes != nil ? 1 : 0;
    //if ( act.Detalles.count > 0 )
    //    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.BotonDetalle.hidden = act.Detalles.count > 0 ? false : true;
    cell.BotonDetalle.tag = indexPath.row;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self.diaActual = item.tag;
    [self.TablaAgenda reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ( [[segue identifier] isEqualToString:@"ver_detalle" ])
    {
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        Dia * actual = [agendaArray objectAtIndex:_diaActual];
        Actividad * act = [actual.Actividades objectAtIndex:tagIndex];
        
        
        UINavigationController * contro = segue.destinationViewController;
        AgendaDetalle * agenda = (AgendaDetalle *)contro.topViewController;
        agenda.ListaDetalle = act.Detalles;
        //controller.ListaDetalle = act.Detalles;
    }
}
@end
