//
//  Database.h
//  SimpleContacts
//
//  Created by Szeyin Lee on 9/30/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrapbookItem.h"
#import <sqlite3.h>

@interface Database : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded;
+ (void)initDatabase;
+ (NSMutableArray *)fetchAllScrapbookItem;
+ (void)saveScrapbookItemWithTitle:(NSString *)title andCaption:(NSString *)caption andPhoto:(NSData *)photo;
+ (void)deleteScrapbookItem:(int)rowid;
+ (void)cleanUpDatabaseForQuit;


@end
