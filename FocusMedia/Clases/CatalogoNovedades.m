//
//  CatalogoNovedades.m
//  FocusMedia
//
//  Created by Administrador on 19/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "CatalogoNovedades.h"
#import "FontAwesome.h"

@interface CatalogoNovedades ()

@end

@implementation CatalogoNovedades
@synthesize emp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.NovedadesLabel.text = emp.Novedades;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
