//
//  RemoteCall.m
//  
//
//  Created by Bruno Fuster Martins Silva on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RemoteCall.h"
#import "SampleItem.h"

@interface RemoteCall()
- (void)doGet:(NSString*)url;
- (void)doPost:(NSString*)url withObject:(id)obj;
- (void)addOperation:(SEL)selector	withObject:(id)object;
- (void)responseCallback:(Response*)response;
@end

@implementation RemoteCall

@synthesize delegate, client, operations;

- (id)initWithDelegate:(id)_delegate {

    self.delegate = _delegate;
    self.operations = [OperationsManager sharedInstance];
    self.client = [Restfulie customWithTypes:[NSArray arrayWithObjects:[SampleItem class], nil]
                          andCollectionNames:[NSArray arrayWithObjects:@"list", nil]];
    
    return self;
}

- (void)get:(NSString *)url {
    
    [self addOperation:@selector(doGet:) withObject:url];
}

- (void)post:(NSString *)url withObject:(id)obj {
    
    //nothing yet
}

#pragma mark Private methods

- (void)doGet:(NSString *)url {
    
    Response *response = [[self.client at:url] get];
    [self responseCallback:response];
}


- (void)doPost:(NSString*)url withObject:(id)obj {
    
    
}

- (void)addOperation:(SEL)selector	withObject:(id)object {
    
	[self.operations startOperationWithParser:self 
                                    method:selector
                                    object:object];
}

- (void)responseCallback:(Response*)response {

    [(id)[self delegate] performSelectorOnMainThread:@selector(response:) 
                                          withObject:response 
                                       waitUntilDone:NO];
}

@end
