//
//  Catalogo.m
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Catalogo.h"
#import "Utiles.h"
#import "CatalogoAdapter.h"
#import "CatalogoInformacion.h"
#import "CatalogoNovedades.h"
#import "CatalogoAsistentes.h"

@interface Catalogo ()
@property (nonatomic,strong) NSMutableArray * catalogoArray;

@property (strong, nonatomic) UITabBarController *myTabbarController;
@property (strong,nonatomic) UIFont * font;
@end

@implementation Catalogo

@synthesize catalogoArray;
@synthesize font;
static NSString *simpleTableIdentifier = @"CatalogoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    font = [ UIFont systemFontOfSize:12.0 ];
    

    Utiles * sharedManager = [Utiles sharedManager];
    CatalogoAdapter *adapter = [[CatalogoAdapter alloc] init];
    
    NSString * ruta =[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sharedManager.CatalogoUrl ];
    if (sharedManager.TodoDescargado){
        ruta =[NSString stringWithFormat:@"%@%@", sharedManager.RutaDescarga,sharedManager.CatalogoUrl];
    }
    
    catalogoArray = [adapter leerInformacion:ruta];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return catalogoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Empresa * emp = [catalogoArray objectAtIndex:indexPath.row];
    
    
    UITableViewCell * cell = [self.TablaCatalogo dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [Header convertHtmlPlainText:emp.Nombre];
    cell.textLabel.font  = font;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:emp.Logo];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)viewDidAppear:(BOOL)animated{
    NSString *nombreApp = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    self.navigationItem.title = nombreApp;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.title = @"";
    [self performSegueWithIdentifier:@"ver_detalle" sender:indexPath];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ( [[segue identifier] isEqualToString:@"ver_detalle" ])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;

        Empresa * emp = [catalogoArray objectAtIndex:indexPath.row];
        
        self.myTabbarController = (UITabBarController*) [segue destinationViewController];
        CatalogoInformacion * cInfo = [self.myTabbarController.viewControllers objectAtIndex:0];
        cInfo.emp = emp;
        
        CatalogoNovedades * cNove = [self.myTabbarController.viewControllers objectAtIndex:1];
        cNove.emp = emp;
        
        CatalogoAsistentes * cAsis = [self.myTabbarController.viewControllers objectAtIndex:2];
        cAsis.emp = emp;
        
    }
}


@end
