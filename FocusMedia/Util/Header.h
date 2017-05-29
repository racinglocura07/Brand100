//
//  Header.h
//  FocusMedia
//
//  Created by Administrador on 6/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Header : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ImagenEvento;
@property (weak, nonatomic) IBOutlet UILabel *FechaEvento;
@property (weak, nonatomic) IBOutlet UILabel *LugarEvento;

+ (NSString*)convertHtmlPlainText:(NSString*)HTMLString;

@end
