//
//  CatalogoInformacion.m
//  FocusMedia
//
//  Created by Administrador on 19/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "CatalogoInformacion.h"
#import "FontAwesome.h"

@interface CatalogoInformacion ()

@end

@implementation CatalogoInformacion
@synthesize emp;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar.items objectAtIndex:0].image = [FontAwesome imageWithIcon:fa_info iconColor:[UIColor blueColor] iconSize:20];
    [self.tabBarController.tabBar.items objectAtIndex:0].title = @"Información";
    
    [self.tabBarController.tabBar.items objectAtIndex:1].image = [FontAwesome imageWithIcon:fa_inbox iconColor:[UIColor blueColor] iconSize:20];
    [self.tabBarController.tabBar.items objectAtIndex:1].title = @"Novedades";
    
    [self.tabBarController.tabBar.items objectAtIndex:2].image = [FontAwesome imageWithIcon:fa_user iconColor:[UIColor blueColor] iconSize:20];
    [self.tabBarController.tabBar.items objectAtIndex:2].title = @"Asistentes";
    
    self.tabBarController.navigationItem.title = emp.Nombre;
    
    self.Info.text = emp.Informacion;
    [self.Info setFont:[UIFont systemFontOfSize:17]];
    self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [self.Info setContentOffset:CGPointZero animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
