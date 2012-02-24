//
//  RemoteCall.h
//
//
//  Created by Bruno Fuster Martins Silva on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restfulie.h"
#import "OperationsManager.h"

@protocol RemoteCallResponse
- (void) response:(Response*)response;
@end

@interface RemoteCall : NSObject

@property (nonatomic,weak) id<RemoteCallResponse> delegate;
@property (nonatomic,weak) id<RestClient> client;
@property (nonatomic,strong) OperationsManager *operations;

- (id) initWithDelegate:(id)_delegate;
- (void) get:(NSString*)url;
- (void) post:(NSString*)url withObject:(id)obj;

@end
