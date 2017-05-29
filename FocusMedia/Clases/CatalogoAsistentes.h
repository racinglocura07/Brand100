//
//  CatalogoDetalle.h
//  FocusMedia
//
//  Created by Administrador on 16/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Empresa.h"

@interface CatalogoAsistentes : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) Empresa * emp;
@property (weak, nonatomic) IBOutlet UICollectionView *ColAsistentes;

@end
