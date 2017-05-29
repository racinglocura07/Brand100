//
//  DBManager.h
//  FocusMedia
//
//  Created by Julian on 5/30/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;



-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;

@end