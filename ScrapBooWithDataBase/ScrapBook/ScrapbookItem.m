//
//  ScrapbookItem.m
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "ScrapbookItem.h"

@implementation ScrapbookItem


-(id)initWithPhoto:(UIImage *)picture andTitle:(NSString *)name andCaption:(NSString *)caption andId:(int)rid
{
    self = [super init];
    self.photo = picture;
    self.title = name;
    self.caption = caption;
    self.rowid = rid;
    return self;
}


@end
