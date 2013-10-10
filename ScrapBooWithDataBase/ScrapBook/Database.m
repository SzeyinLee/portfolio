//
//  Database.m
//  SimpleContacts
//
//  Created by Szeyin Lee on 9/30/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "Database.h"



#import <sqlite3.h>


@implementation Database

static sqlite3 *db;

static sqlite3_stmt *createScrapbookItem;
static sqlite3_stmt *fetchScrapbookItem;
static sqlite3_stmt *insertScrapbookItem;
static sqlite3_stmt *deleteScrapbookItem;

+ (void)createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    
    // look for an existing contacts database
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"itemlist.sql"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    // if failed to find one, copy the empty contacts database into the location
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"itemlist.sql"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"FAILED to create writable database file with message, '%@'.", [error localizedDescription]);
    }
}

+ (void)initDatabase {
    // create the statement strings
    const char *createScrapbookItemString = "CREATE TABLE IF NOT EXISTS itemlist (rowid INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, caption TEXT, photo BLOB)";
    const char *fetchScrapbookItemString = "SELECT * FROM itemlist";
    const char *insertScrapbookItemString = "INSERT INTO itemlist (title, caption, photo) VALUES (?, ?, ?)";
    const char *deleteScrapbookItemString = "DELETE FROM itemlist WHERE rowid=?";
    
    // create the path to the database
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"itemlist.sql"];
    
    // open the database connection
    if (sqlite3_open([path UTF8String], &db)) {
        NSLog(@"ERROR opening the db");
    }
    
    

    int success;

    //init table statement
    if (sqlite3_prepare_v2(db, createScrapbookItemString, -1, &createScrapbookItem, NULL) != SQLITE_OK) {
        NSLog(@"Failed to prepare contacts create table statement");
    }
    
    // execute the table creation statement
    success = sqlite3_step(createScrapbookItem);
    sqlite3_reset(createScrapbookItem);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to create contacts table");
    }
    
    //init retrieval statement
    if (sqlite3_prepare_v2(db, fetchScrapbookItemString, -1, &fetchScrapbookItem, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare contact fetching statement");
    }
    
    //init insertion statement
    if (sqlite3_prepare_v2(db, insertScrapbookItemString, -1, &insertScrapbookItem, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare contact inserting statement");
    }
    
    // init deletion statement
    if (sqlite3_prepare_v2(db, deleteScrapbookItemString, -1, &deleteScrapbookItem, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare contact deleting statement");
    }
}

+ (NSMutableArray *)fetchAllScrapbookItem
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:0];
    
    
    
    while (sqlite3_step(fetchScrapbookItem) == SQLITE_ROW) {
        
        // query columns from fetch statement
        char *titleChars = (char *) sqlite3_column_text(fetchScrapbookItem, 1);
        char *captionChars = (char *) sqlite3_column_text(fetchScrapbookItem, 2);
        int size = sqlite3_column_bytes(fetchScrapbookItem, 3);
        NSData *photo = [NSData dataWithBytes:sqlite3_column_blob(fetchScrapbookItem, 3) length:size];
                         
                
        // convert to NSStrings
        NSString *temptitle = [NSString stringWithUTF8String:titleChars];
        NSString *tempcaption = [NSString stringWithUTF8String:captionChars];
        UIImage *tempphoto = [UIImage imageWithData:photo];
        
        //create Contact object, notice the query for the row id
        ScrapbookItem *temp =[[ScrapbookItem alloc] initWithPhoto:tempphoto andTitle:temptitle andCaption:tempcaption andId:sqlite3_column_int(fetchScrapbookItem, 0)];
        [ret addObject:temp];
        
    }
    
    sqlite3_reset(fetchScrapbookItem);
    return ret;
}

+ (void)saveScrapbookItemWithTitle:(NSString *)title andCaption:(NSString *)caption andPhoto:(NSData *)photo
{
    // bind data to the statement
    sqlite3_bind_text(insertScrapbookItem, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertScrapbookItem, 2, [caption UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_blob(insertScrapbookItem, 3, [photo bytes], [photo length], SQLITE_TRANSIENT);
    
    int success = sqlite3_step(insertScrapbookItem);
    sqlite3_reset(insertScrapbookItem);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to insert contact");
    }
}

+ (void)deleteScrapbookItem:(int)rowid
{
    // bind the row id, step the statement, reset the statement, check for error... EASY
    sqlite3_bind_int(deleteScrapbookItem, 1, rowid);
    int success = sqlite3_step(deleteScrapbookItem);
    sqlite3_reset(deleteScrapbookItem);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to delete contact");
    }
}

+ (void)cleanUpDatabaseForQuit
{
    // finalize frees the compiled statements, close closes the database connection
    sqlite3_finalize(fetchScrapbookItem);
    sqlite3_finalize(insertScrapbookItem);
    sqlite3_finalize(deleteScrapbookItem);
    sqlite3_finalize(createScrapbookItem);
    sqlite3_close(db);
}

@end
