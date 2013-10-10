//
//  ISInstagramTagSearcher.h
//  InstaSearch
//
//  Created by Szeyin Lee on 9/18/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISInstagramTagSearcher : NSObject
@property NSURLConnection* connection;
@property NSMutableData* data;
@property id target;
@property SEL action;

- (id) initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
