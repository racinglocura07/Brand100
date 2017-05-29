//
//  SharedNavigationController.m
//  FocusMedia
//
//  Created by Administrador on 5/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "SharedNavigationController.h"

@interface SharedNavigationController ()

@end

@implementation SharedNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *nombreApp = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
  
    UIBarButtonItem * menuBoton = [[UIBarButtonItem alloc]
                                   initWithImage:[FontAwesome imageWithIcon:fa_list iconColor:[UIColor blackColor] iconSize:25]
                                   style:UIBarButtonItemStyleDone
                                   target:self.revealViewController
                                   action:@selector(revealToggleAnimated:)];
    
    self.navigationItem.leftBarButtonItem = menuBoton;
    self.navigationItem.title = nombreApp; 
    
}


@end
