//
//  FSFlickrTagSearcher.m
//  FlickrImageSearch
//
//  Created by Szeyin Lee on 9/24/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "FSFlickrTagSearcher.h"

@implementation FSFlickrTagSearcher
- (id) initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super init];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=7e63eb06f6f96eb115c47e8762135e68&tags=%@&format=json&nojsoncallback=1", query]]] delegate:self];
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
