//
//  Header.m
//  FocusMedia
//
//  Created by Administrador on 6/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Header.h"

@interface Header ()

@end

@implementation Header

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIImage * ImagenEvento = [UIImage imageNamed:@"Recursos/Eventos/main-logo.png"];
    
    NSString * Fecha = @"5-8 <strong>OCT</strong> 2015";
    NSString * Lugar = @"Sheraton Hotel";
    
    
    self.ImagenEvento.image = ImagenEvento;
    //self.ImagenEvento.
    self.FechaEvento.text = [Header convertHtmlPlainText:Fecha];
    self.LugarEvento.text = [Header convertHtmlPlainText:Lugar];
}

+ (NSString*)convertHtmlPlainText:(NSString*)HTMLString{
    
    NSData *HTMLData = [HTMLString dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    
    return plainString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
