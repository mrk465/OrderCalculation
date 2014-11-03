//
//  DatabaseClass.h
//  OrderCalculation
//
//  Created by Ravikanth Muthavarapu on 10/10/14.
//  Copyright (c) 2014 Ravikanth Muthavarapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DatabaseClass : NSObject{
    sqlite3 *ItemsDB;
    NSString *databasePath;
 
}
+ (DatabaseClass *)sharedInstance;
-(NSArray*)getAllValues:(NSString*)forfield;
@end
