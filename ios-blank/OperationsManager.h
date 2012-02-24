//
//  OperationsManager.h
//  
//
//  Created by Bruno Fuster on 1/25/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OperationsManager : NSObject {

	NSMutableArray *operations;
	NSOperationQueue *operationQueue;
}

@property (nonatomic, retain) NSMutableArray *operations;
@property (nonatomic, retain) NSOperationQueue *operationQueue;

+ (id) sharedInstance;

- (void) startOperationWithDelegate:(id)delegate method:(SEL)method object:(id)obj;
- (void) finishOperationForDelegate:(id)delegate method:(SEL)method object:(id)obj;

- (void) startOperationWithParser:(id)parser method:(SEL)method object:(id)obj;
- (void) finishOperationForParser:(id)parser method:(SEL)method object:(id)obj;

- (void) startActivity;
- (void) stopActivity;
- (void) cancelAll;

@end
