//
//  GFFirstViewController.h
//  
//
//  Created by Bruno Fuster Martins Silva on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteCall.h"

@interface GFFirstViewController : UIViewController<RemoteCallResponse>

@property (nonatomic,strong) RemoteCall *remoteCall;
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) IBOutlet UITableView *tableView;

@end
