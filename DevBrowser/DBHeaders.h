//
//  DBHeaders.h
//  DevBrowser
//
//  Created by Andy Attebery on 3/4/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DBHeaders : NSObject<UITableViewDataSource>
{
    NSMutableDictionary *headers;
}

+ (NSMutableDictionary *) getHeaders;
+ (BOOL) saveHeaders:(NSMutableDictionary *)fromDictionary;
    
@end
