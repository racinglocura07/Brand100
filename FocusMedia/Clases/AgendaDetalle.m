//
//  AgendaDetalle.m
//  FocusMedia
//
//  Created by Administrador on 10/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "AgendaDetalle.h"
#import "DetalleCell.h"
#import "Detalle.h"
#import "Actividad.h"
#import "Header.h"

@interface AgendaDetalle ()

@end

@implementation AgendaDetalle
@synthesize ListaDetalle;

static NSString *simpleTableIdentifier = @"DetalleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.BotonAtras.target = self;
    self.BotonAtras.action = @selector(volverAtras);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)volverAtras{
    NSLog(@"%@",self.navigationController.viewControllers);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static DetalleCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [self.TablaDetalle dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat total = 0;
    total += [cell.TituloDetalle systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    
    if ( cell.SubTituloDetalle.tag == 1 )
        total += [cell.SubTituloDetalle systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    total += [cell.ImagenesDetalle systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    total += [cell.DescripcionDetalle systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    total += [self heightForText:cell.DescripcionDetalle.text font:cell.DescripcionDetalle.font withinWidth:screenWidth ];
    
    
    return total + 40; // + total + prueba; //.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ListaDetalle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetalleCell *cell = [self.TablaDetalle dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    [self setUpCell:cell atIndexPath:indexPath];
    
    //cell.textLabel.text = @"Prueba";
    return cell;
}

- (void)setUpCell:(DetalleCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    Detalle * detalle = [ListaDetalle objectAtIndex:indexPath.row];
    
    cell.TituloDetalle.text = [Header convertHtmlPlainText:detalle.Titulo];
    cell.SubTituloDetalle.text = [Header convertHtmlPlainText:detalle.SubTitulo];
    cell.DescripcionDetalle.text = [Header convertHtmlPlainText:detalle.Descripcion];
    
    NSMutableArray * Imagenes = [[NSMutableArray alloc] init];
    for (NSString * imagen in detalle.Imagenes) {
        [Imagenes addObject:[UIImage imageNamed:imagen]];
    }
    cell.ImagenesDetalle.image = [Imagenes objectAtIndex:0];
    
    
    cell.SubTituloDetalle.hidden = detalle.SubTitulo == nil;
    cell.SubTituloDetalle.tag = detalle.SubTitulo == nil ? 0 : 1;
}

- (CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    
    font = [UIFont systemFontOfSize:17];
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    return ceilf(height / font.lineHeight) * font.lineHeight;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Detalle * detalle = [ListaDetalle objectAtIndex:indexPath.row];
    
    NSMutableArray * Imagenes = [[NSMutableArray alloc] init];
    for (NSString * imagen in detalle.Imagenes) {
        [Imagenes addObject:[UIImage imageNamed:imagen]];
    }
    DetalleCell * detCell = (DetalleCell * ) cell;
    detCell.ImagenesDetalle.animationImages = Imagenes;
    detCell.ImagenesDetalle.animationDuration = 10;
    [detCell.ImagenesDetalle startAnimating];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.imageView stopAnimating];
    [cell.layer removeAllAnimations];
}

@end
