//
//  OperationsManager.m
//  
//
//  Created by Bruno Fuster on 1/25/11.
//  Copyright 2011. All rights reserved.
//

#import "OperationsManager.h"

typedef enum {
	WSOperationStatusEmpty, 
	WSOperationStatusLastOperation
} WSOperationStatus;

static OperationsManager *sharedInstance = nil;

@implementation OperationsManager

@synthesize operations;
@synthesize operationQueue;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.operations = [[[NSMutableArray alloc] init] autorelease];
		self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
		[self.operationQueue setMaxConcurrentOperationCount:3];
	}
	return self;
}


+ (id) sharedInstance {

	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [[self alloc] init];
		}
	}
	
	return sharedInstance;
}

- (void) startOperationWithDelegate:(id)delegate method:(SEL)method object:(id)obj {

	if ([self.operations count] == WSOperationStatusEmpty) {

		[self performSelectorOnMainThread:@selector(startActivity)
							   withObject:nil
							waitUntilDone:NO];
		
	}
	
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:delegate 
																	 selector:method 
																	   object:obj];
	NSString *operationKey = [NSString stringWithFormat:@"%@%@%@", 
							  [delegate description], NSStringFromSelector(method), [obj description]];
	
	[self.operations addObject:operationKey];
	[self.operationQueue addOperation:op];
	[op release];

}

- (void) finishOperationForDelegate:(id)delegate method:(SEL)method object:(id)obj {

	if ([self.operations count] == WSOperationStatusLastOperation) {
	
		[self performSelectorOnMainThread:@selector(stopActivity)
							   withObject:nil
							waitUntilDone:NO];
		
	}
		
	if ([self.operations count] != WSOperationStatusEmpty) 
		[self.operations removeLastObject];
	
}

- (void) startOperationWithParser:(id)parser method:(SEL)method object:(id)obj {

	// Since it's a parser, try to retain the delegate
	if ( [parser respondsToSelector:@selector(delegate)] ) {

		id delegate = [parser performSelector:@selector(delegate)];
		[delegate performSelector:@selector(retain)];
	}
	
	[self startOperationWithDelegate:parser method:method object:obj];
}

- (void) finishOperationForParser:(id)parser method:(SEL)method object:(id)obj {
	
	// Since it's a parser, try to release the delegate
	if ( [parser respondsToSelector:@selector(delegate)] ) {

		id delegate = [parser performSelector:@selector(delegate)];
		[delegate performSelector:@selector(release)];
	}
	
	[self finishOperationForDelegate:parser method:method object:obj];
}

- (void) cancelAll {

	[self.operationQueue cancelAllOperations];
	
	[self.operations removeAllObjects];
	[self stopActivity];
	
}

- (void) startActivity {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) stopActivity {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) dealloc
{
	[self cancelAll];
	[self.operations release];
	[self.operationQueue release];
	[super dealloc];
}


@end
