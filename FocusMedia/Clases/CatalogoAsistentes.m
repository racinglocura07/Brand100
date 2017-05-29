//
//  CatalogoDetalle.m
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Asistentes.h"
#import "CatalogoAsistentes.h"
#import "FontAwesome.h"
#import "AsistentesCell.h"
#import "Header.h"

@interface CatalogoAsistentes ()

@end

@implementation CatalogoAsistentes
@synthesize emp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout *flowLayout = [self.ColAsistente];
    self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    //[self.ColAsistentes scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return emp.Asistentes.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Asistentes *cellData = [emp.Asistentes objectAtIndex:indexPath.row];
    
    
    AsistentesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"saCell" forIndexPath:indexPath];
    
    cell.laNombre.text = [Header convertHtmlPlainText:cellData.Nombre];
    cell.laCargo.text = cellData.Descripcion;
    cell.imAsistentes.image = [UIImage imageNamed:cellData.Imagen];
    NSLog(@"%@", cellData.Imagen);
    
    return cell;
    
}

@end
