//
//  DatabaseClass.m
//  OrderCalculation
//
//  Created by Ravikanth Muthavarapu on 10/10/14.
//  Copyright (c) 2014 Ravikanth Muthavarapu. All rights reserved.
//

#import "DatabaseClass.h"

@implementation DatabaseClass
+ (DatabaseClass *)sharedInstance{
    static dispatch_once_t onceToken;
    static DatabaseClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[DatabaseClass alloc] init];
    });
    return instance;
};
- (id)init {
    self = [super init];
    if (self) {
        
        
        NSString *docsDir;
        NSArray *dirPaths;
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ItemsDB.sqlite"]];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        if ([filemgr fileExistsAtPath: databasePath ] == NO)
        {
            const char *dbpath = [databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &ItemsDB) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ItemsTable (ID INTEGER, ItemName TEXT,ItemQty INTEGER, ItemCost INTEGER)";
                
                if (sqlite3_exec(ItemsDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
                {
                    NSLog(@"Failed to create table");
                }
                else {
                    NSString *insertSQL;
                    for (int i=1; i<=10; i++) {
                        NSString *itemname=[NSString stringWithFormat:@"Item%d",i];
                        NSInteger qntty=90+i;
                        NSInteger costOfItem=100+i;
                        insertSQL = [NSString stringWithFormat: @"INSERT INTO ItemsTable (ID,ItemName,ItemQty,ItemCost) VALUES(%d,%@,%d,%d)",i,itemname,qntty,costOfItem];
                        NSLog(@"%@",insertSQL);
                        const char *insert_stmt = [insertSQL UTF8String];
                        char *errMsg;
                        sqlite3_exec(ItemsDB, insert_stmt, NULL, NULL, &errMsg);
                    }
                    
                }
                
                sqlite3_close(ItemsDB);
                
            } else {
                NSLog(@"Failed to open/create database");
                
            }
        }

    }
    return self;
}
-(NSArray*)getAllValues:(NSString*)forfield{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &ItemsDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"Select *FROM ItemsTable"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(ItemsDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            NSLog(@"qty:%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]);
//            AddtolistName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
//            Addtolistmobileno = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
//            AddtolistNotifytype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
//            DvcTokenFromDB=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
//            userofrstatusformDB=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            
            
            
        } else {
            
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(ItemsDB);
        
    }
    
    
    NSArray *arr;
    return arr;
}
@end
