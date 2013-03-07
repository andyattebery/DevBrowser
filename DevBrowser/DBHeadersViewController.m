//
//  DBHeadersViewController.m
//  DevBrowser
//
//  Created by Andy Attebery on 2/28/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import "DBHeaders.h"
#import "DBHeadersViewController.h"

@implementation DBHeadersViewController

NSString *const HeaderCellId = @"headerCell";

@synthesize headersTableView, txtJSONURL, txtName, txtValue;

- (void)viewDidLoad
{
    [super viewDidLoad];

    headersTableView.delegate = self;
    headersTableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    headers = [DBHeaders getHeaders];
}


- (IBAction)btnCloseClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:NULL];
}

- (IBAction)btnAddClick:(id)sender {
    if (txtName.text.length > 0 && txtValue.text.length > 0) {
        [txtName resignFirstResponder];
        [txtValue resignFirstResponder];
        
        [headers setObject:txtValue.text forKey:txtName.text];
        [DBHeaders saveHeaders:headers];
        txtName.text = nil;
        txtValue.text = nil;
        [headersTableView reloadData];
    }
}

- (IBAction)btnImportClick:(id)sender {
    if (txtJSONURL.text.length > 0)
    {
        [txtJSONURL resignFirstResponder];
        
        NSError *error = nil;
        NSURL *url = [NSURL URLWithString:txtJSONURL.text];
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        if (error != nil)
        {
            [self displayAlertViewWith:error.description];
            return;
        }
        
        id jSONHeaders = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error != nil)
        {
            [self displayAlertViewWith:error.description];
            return;
        }
        
        for (NSDictionary *item in jSONHeaders)
        {
            [headers setObject:[item objectForKey:@"value"] forKey:[item objectForKey:@"name"]];
        }
        [DBHeaders saveHeaders:headers];
        [headersTableView reloadData];
    }
}

- (void) displayAlertViewWith:(NSString *)string
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:string delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark UITableViewDelegate Members

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [headers ]
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [headers removeObjectForKey:[[headers allKeys] objectAtIndex:indexPath.row]];
    [DBHeaders saveHeaders:headers];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView reloadData];
}


#pragma mark UITableViewDataSource Members

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return headers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellId];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:HeaderCellId];
    }
    
    NSString *name = [[headers allKeys] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [headers objectForKey:name];
    
    
    return cell;
}

@end
