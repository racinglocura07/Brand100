//
//  Bienvenida.m
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Bienvenida.h"

@interface Bienvenida ()

@end

@implementation Bienvenida

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Utiles * sharedManager = [Utiles sharedManager];
    

    NSString * imagen =[NSString stringWithFormat:@"%@arc.jpg",sharedManager.BienvenidaUrl];
    NSString * TituloBienvenida = @"Bienvenidos al origen";
    NSString * textoBienvenida = @"<p>Gracias por  ser parte de esta séptima edición de <strong>Brand  100</strong>, que reune nuevamente a los grandes decisores del mercado publicitario:  medios, anunciantes y agencias de medios, juntos en un evento único.</p><p>Después de  varios años en los que recorrimos el país, desde Salta hasta El Calafate, hoy  volvemos a Mendoza, en donde se realizó la primera edición de <strong>Brand 100</strong>. Muchas cosas han  evolucionado en estos años, especialmente en lo que tiene que ver con plataformas,  tecnologías y dispositivos, y nosotros las hemos acompañado con el evento.</p><p>Hoy estamos  aquí, a miles de kilómetros de la oficina, para hacer excelentes negocios y  contactos, de una manera muy diferente a la del día a día habitual. Vas a  acceder a propuestas innovadoras y exclusivas, que te van a ayudar en tu  trabajo. Además, podrás disfrutar de actividades recreativas que favorecen el  networking entre todos los participantes.</p><p>Vas a  acceder también a contenidos exclusivos, en 2 conferencias de primer nivel,  presentadas por Telefe el IAB.</p><p>En esta aplicación  tenés una Agenda detallada de las actividades programadas para vos, así como  información sobre los medios que participan de <strong>Brand 100</strong>. </p><p>Todo nuestro  equipo está a tu entera disposición para responder y solucionar cualquier  necesidad. No dudes en consultarnos.</p><p>Esperamos  que disfrutes cada momento de negocios, contactos y esparcimiento. ¡Hagamos  juntos un gran evento!</p><p>Cordiales saludos,<br>Arturo R Cuestas.<br>CEO<br>Focus  Media S.A.</p></p>";
    
    NSString * rutaTextos =[NSString stringWithFormat:@"%@/%@Textos.cfg", [[NSBundle mainBundle] resourcePath], sharedManager.BienvenidaUrl ];
    
    if (sharedManager.TodoDescargado){
        imagen = [NSString stringWithFormat:@"%@%@arc.jpg", sharedManager.RutaDescarga,sharedManager.BienvenidaUrl];
        rutaTextos = [NSString stringWithFormat:@"%@%@Textos.cfg", sharedManager.RutaDescarga,sharedManager.BienvenidaUrl];
    }
    

    NSString* fileContents = [NSString stringWithContentsOfFile:rutaTextos encoding:NSUTF8StringEncoding error:nil];
    NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for ( NSString * line in lines ){
        
        if ( [line containsString:@"Titulo"] )
            TituloBienvenida = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ( [line containsString:@"Descripcion"] )
            textoBienvenida = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    
    
    self.ImagenBienvenida.image = [UIImage imageNamed:imagen];
    
    self.TituloBienvenida.text = [Header convertHtmlPlainText:TituloBienvenida];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[textoBienvenida dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} range:NSMakeRange(0, attributedString.length)];
    
    self.TextoBienvenida.attributedText = attributedString;
    self.TextoBienvenida.textColor = [UIColor whiteColor];
    
    //[self.TextoBienvenida setFont:[UIFont systemFontOfSize:17]];
    
}

- (void)viewDidLayoutSubviews {
    [self.TextoBienvenida setContentOffset:CGPointZero animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
