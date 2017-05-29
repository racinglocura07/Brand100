//
//  Home.m
//  FocusMedia
//
//  Created by Administrador on 5/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Home.h"
#import "DBManager.h"
#import <CRToast/CRToast.h>

@interface Home ()

@end

@implementation Home
static NSString * colorPred;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    Utiles * sharedManager = [Utiles sharedManager];
    
    NSString * rutaLogo = @"Recursos/Eventos/main-logo.png";
    NSString * rutaSponsors = nil;
    NSString * rutaImagenes = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sharedManager.HomeUrl ];
    NSString * rutaTextos = [NSString stringWithFormat:@"%@/%@Textos.cfg", [[NSBundle mainBundle] resourcePath], sharedManager.HomeUrl ];
    
    NSString * Fecha = @"22-25 <strong>AGO</strong> 2016";
    NSString * Lugar = @"Sheraton Hotel, Tucumán";
    NSString * InfoEvento = @"Bienvenido a la <b>APP</b> Oficial de<br><b>Retail 100 Construcción</b>";
    NSString * Color = nil;
    
    UIImage * imagenSponsor = nil;
    
    if (sharedManager.TodoDescargado){
        rutaLogo = [NSString stringWithFormat:@"%@%@main-logo.png", sharedManager.RutaDescarga,sharedManager.EventosUrl];
        rutaImagenes = [NSString stringWithFormat:@"%@%@", sharedManager.RutaDescarga,sharedManager.HomeUrl];
        rutaTextos =[NSString stringWithFormat:@"%@%@Textos.cfg", sharedManager.RutaDescarga,sharedManager.HomeUrl];;
    }
    
    NSString* fileContents = [NSString stringWithContentsOfFile:rutaTextos encoding:NSUTF8StringEncoding error:nil];
    NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for ( NSString * line in lines ){
        
        if ( [line containsString:@"Fecha"] )
            Fecha = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ( [line containsString:@"Lugar"] )
            Lugar = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ( [line containsString:@"Info"] )
            InfoEvento = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ( [line containsString:@"Color"] )
            Color = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ( [line containsString:@"Sponsors"] )
            rutaSponsors = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    colorPred = Color;
    
    Lugar = [Lugar stringByReplacingOccurrencesOfString:@"-" withString:@"<br/>"];
    
    NSMutableArray * imagenes = [[NSMutableArray alloc] init];
    NSMutableArray * todo =[Utiles getFiles:rutaImagenes condition:@".jpg" aImagen:false conExtension:YES];
    for (NSString * imagen in todo) {
        if (rutaSponsors != nil )
        {
            if (![imagen hasSuffix:rutaSponsors])
                [imagenes addObject:[UIImage imageNamed:imagen]];
            else
                imagenSponsor =[UIImage imageNamed:imagen];
        }
        else
            [imagenes addObject:[UIImage imageNamed:imagen]];
    }
    
    if (rutaSponsors == nil )
        [self.ImagenSponsor setHidden:YES];
    
    
    self.ImagenEvento.image = [UIImage imageNamed:rutaLogo];
    self.ImagenSponsor.image = imagenSponsor;
    self.FechaEvento.text = [Header convertHtmlPlainText:Fecha];
    self.LugarEvento.text = [Header convertHtmlPlainText:Lugar];
    
    self.Carousel.animationImages = imagenes;
    self.Carousel.animationDuration = 50;
    self.InfoEvento.text = [Header convertHtmlPlainText:InfoEvento];
    if ( Color != nil)
        self.InfoEvento.backgroundColor = [Home colorWithHexString:Color];
    
    [self.Carousel startAnimating];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString * ) traerColor{
    return colorPred;
}

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    cString = [cString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
