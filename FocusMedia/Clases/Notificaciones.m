//
//  Notificaciones.m
//  FocusMedia
//
//  Created by Julian on 5/30/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import "Notificaciones.h"
#import "DBManager.h"
#import "Home.h"


@interface Notificaciones ()
@property (nonatomic,strong) NSMutableArray * notificacionesArray;
@property (nonatomic,strong) DBManager * dbManager;
@end

@implementation Notificaciones

static NSString *simpleTableIdentifier = @"NotificacionesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"notificaciones.db"];
    
    NSString *query = @"select * from notificaciones";
    
    self.notificacionesArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    
     self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75; //.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notificacionesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.TablaNotificaciones dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    
    NSInteger row = indexPath.row;
    NSString * titulo = [[self.notificacionesArray objectAtIndex:row] objectAtIndex:1];
    NSString * cuerpo = [[self.notificacionesArray objectAtIndex:row] objectAtIndex:2];

    
    
    cell.textLabel.text = [Header convertHtmlPlainText:titulo];
    cell.detailTextLabel.text = [Header convertHtmlPlainText:cuerpo];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction * btn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Borrar" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath){
        [self borrarFila:indexPath];
    }];
    
    NSString * color = [Home traerColor];
    
    btn.backgroundColor = [Home colorWithHexString:color];
    
    return @[btn];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void) borrarFila:(NSIndexPath *) indexPath{
    NSInteger row = indexPath.row;
    int recordIDToDelete = [[[self.notificacionesArray objectAtIndex:row] objectAtIndex:0] intValue];
    
    NSString *query = [NSString stringWithFormat:@"delete from notificaciones where idNotificacion=%d", recordIDToDelete];
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    query = @"select * from notificaciones";
    self.notificacionesArray = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    [self.TablaNotificaciones reloadData];
    NSLog(@"Borrada");
    
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
