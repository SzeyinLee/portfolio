//
//  ScrapbookItem.h
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INETImageView.h"

@interface ScrapbookItem : NSObject

@property int rowid;
@property UIImage *photo;
@property NSString *title;
@property NSString *caption;

-(id)initWithPhoto:(UIImage *)picture andTitle:(NSString *)name andCaption:(NSString *)caption andId:(int)rid;

@end
