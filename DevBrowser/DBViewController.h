//
//  DBViewController.h
//  DevBrowser
//
//  Created by Andy Attebery on 2/27/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBViewController : UIViewController <UIWebViewDelegate, UITextFieldDelegate>

- (IBAction)btnGoClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *setHeadersButton;
@property (weak, nonatomic) IBOutlet UITextField *addressBar;



@end
