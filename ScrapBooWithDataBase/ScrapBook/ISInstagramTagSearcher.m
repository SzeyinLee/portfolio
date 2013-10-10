//
//  ISInstagramTagSearcher.m
//  InstaSearch
//
//  Created by Szeyin Lee on 9/18/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "ISInstagramTagSearcher.h"

@implementation ISInstagramTagSearcher

- (id) initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super init];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=52b557afb1c64d5aa7480bef6c368f3e", query]]] delegate:self];
        self.target = incomingTarget;
        self.action = incomingAction;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{  
    self.data = [[NSMutableData alloc] initWithCapacity:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{   //put data into self.data
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //collect the data into dictionary
    NSMutableDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    
    [self.target performSelector:self.action withObject:dictionary];
    
    
}

@end
