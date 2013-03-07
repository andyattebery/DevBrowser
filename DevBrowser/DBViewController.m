//
//  DBViewController.m
//  DevBrowser
//
//  Created by Andy Attebery on 2/27/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import "DBHeaders.h"
#import "DBViewController.h"

@interface DBViewController () {
    NSDictionary *headers;
}
@end

@implementation DBViewController

@synthesize mainWebView, setHeadersButton, addressBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    addressBar.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    headers = [DBHeaders getHeaders];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate Implementation

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{    
    if(headers.count == 0)
    {
        return YES;
    }
    
    NSString *firstHeaderKey = [[headers allKeys] objectAtIndex:0];    
    if ([[request allHTTPHeaderFields] objectForKey:firstHeaderKey] != nil)
    {
        return YES;
    }
    else
    {
        NSMutableURLRequest *modifiedRequest = [request mutableCopy];
        [modifiedRequest setHTTPShouldUsePipelining:NO];
        for(NSString *key in [headers allKeys]){
            [modifiedRequest addValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
        [mainWebView loadRequest:modifiedRequest];
        return NO;
    }
}



- (IBAction)btnGoClicked:(id)sender {
    [self loadRequestFromAddressBar];
}


#pragma mark UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loadRequestFromAddressBar];
    return TRUE;
}

- (void) loadRequestFromAddressBar
{
    [addressBar resignFirstResponder];
    
    NSString *url = addressBar.text;
    
    if ([url rangeOfString:@"http"].location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@", url];
        addressBar.text = url;
    }
    
    if (url.length > 0)
    {
        [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

@end
