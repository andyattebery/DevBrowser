//
//  DBHeadersViewController.h
//  DevBrowser
//
//  Created by Andy Attebery on 2/28/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import <UIKIt/UIKit.h>

@interface DBHeadersViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *headers;
}

- (IBAction)btnCloseClick:(id)sender;
- (IBAction)btnImportClick:(id)sender;
- (IBAction)btnAddClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *headersTableView;
@property (weak, nonatomic) IBOutlet UITextField *txtJSONURL;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtValue;


@end
