//
//  DBHeaders.m
//  DevBrowser
//
//  Created by Andy Attebery on 3/4/13.
//  Copyright (c) 2013 Andy Attebery. All rights reserved.
//

#import "DBHeaders.h"

@implementation DBHeaders

NSString *const HeadersFilename = @"headers.plist";
//NSString *const HeaderCellId = @"headerCell";
//
//- (id)init
//{
//    if (self = [self init]) {
//        headers = [[self class] getHeaders];
//    }
//    return self;
//}


+ (NSMutableDictionary *) getHeaders
{
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] initWithContentsOfFile:[[self class] getHeadersFilePath]];
    if (headers == nil)
    {
        return [[NSMutableDictionary alloc] init];
    }
    else
    {
        return headers;
    }
}

+ (BOOL) saveHeaders:(NSMutableDictionary *)fromDictionary
{
    return [fromDictionary writeToFile: [[self class] getHeadersFilePath] atomically:TRUE];
}

+ (NSString *) getHeadersFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, TRUE);
    if (paths != nil)
    {
        NSString *path = [NSString stringWithFormat:@"%@/%@", [paths lastObject], HeadersFilename];
        return path;
    }
    return nil;
}

//#pragma mark UITableViewDataSource Members
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return headers.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellId];
//    
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:HeaderCellId];
//    }
//    
//    NSString *name = [[headers allKeys] objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = name;
//    cell.detailTextLabel.text = [headers objectForKey:name];
//    
//    return cell;
//}

@end
