//
//  Planos.m
//  FocusMedia
//
//  Created by Administrador on 7/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Planos.h"

@interface Planos ()
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,strong) NSMutableArray * planosArray;
@property (nonatomic,strong) NSMutableArray * titulosArray;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end

@implementation Planos
@synthesize imageView = _imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Utiles * sharedManager = [Utiles sharedManager];
    
    NSString * rutaImagenes =[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sharedManager.PlanosUrl ];
    
    if (sharedManager.TodoDescargado){
        rutaImagenes = [NSString stringWithFormat:@"%@%@", sharedManager.RutaDescarga,sharedManager.PlanosUrl];
    }
    
    _planosArray = [Utiles getFiles:rutaImagenes condition:@".jpg"];
    _titulosArray = [Utiles getFiles:rutaImagenes condition:@".jpg" conExtension:false];
    
    NSMutableArray *tbItems = [NSMutableArray arrayWithArray:[self.TabBar items]];
    for ( int i = 0; i < _titulosArray.count; i++ ) // NSString * plano in imagenesPlanos)
    {
        NSString * Titulo = [_titulosArray objectAtIndex:i];
        
        UITabBarItem *localTabBarItem = [[UITabBarItem alloc] initWithTitle:Titulo image:[FontAwesome imageWithIcon:fa_map_marker iconColor:[UIColor blueColor] iconSize:20] tag:i];
        [tbItems addObject:localTabBarItem];
        
    }
    [self.TabBar setItems:tbItems];
    
    
    // 3
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.ScrollPlanos addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.ScrollPlanos addGestureRecognizer:twoFingerTapRecognizer];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_planosArray.count == 0)
        return;
    
    [super viewDidAppear:animated];
    [self setImage:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.ScrollPlanos.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.ScrollPlanos.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.ScrollPlanos.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.ScrollPlanos.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.ScrollPlanos zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.ScrollPlanos.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.ScrollPlanos.minimumZoomScale);
    [self.ScrollPlanos setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self setImage:item.tag];
}

- (void)setImage:(NSInteger)tag{
    UIImage *image = [UIImage imageNamed:[_planosArray objectAtIndex:tag]];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 20.0f), .size=image.size};
    
    NSArray *viewsToRemove = [self.ScrollPlanos subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];
    
    [self.ScrollPlanos addSubview:self.imageView];
    self.ScrollPlanos.contentSize = image.size;
    
    [self.TabBar setSelectedItem:[self.TabBar.items objectAtIndex:tag]];
    
    CGRect scrollViewFrame = self.ScrollPlanos.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.ScrollPlanos.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.ScrollPlanos.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.ScrollPlanos.minimumZoomScale = minScale;
    
    // 5
    self.ScrollPlanos.maximumZoomScale = 1.0f;
    self.ScrollPlanos.zoomScale = minScale;
    
    // 6
    [self centerScrollViewContents];
}

@end
