//
//  LogsTableViewController.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/20.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "LogsTableViewController.h"
#import "AddNewLogViewController.h"
#import "LogDetailViewController.h"

@interface LogsTableViewController ()

@property (nonatomic, strong) NSMutableArray *logs;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateFormatter *fileNameFormatter;

@end

@implementation LogsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.logs = [NSMutableArray new];
    
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *files = [manager contentsOfDirectoryAtPath:dir error:nil];
    files = [files sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *path in [files reverseObjectEnumerator]) {
        [self.logs addObject:[dir stringByAppendingPathComponent:path]];
    }
    
    self.formatter = [NSDateFormatter new];
    self.formatter.locale = [NSLocale currentLocale];
    self.formatter.dateStyle = NSDateFormatterShortStyle;
    self.formatter.timeStyle = NSDateFormatterShortStyle;

    self.fileNameFormatter = [NSDateFormatter new];
    [self.fileNameFormatter setLocale:[NSLocale systemLocale]];
    [self.fileNameFormatter setDateFormat:@"yyyyMMddHHmmss"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.logs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    WGLog *log = [self logForIndexPath:indexPath];
    
    cell.imageView.image = log.image;
    cell.textLabel.text = [self.formatter stringFromDate:log.timestamp];
    
    NSUInteger successes = 0;
    NSUInteger failures = 0;
    
    NSTimeInterval average = 0;
    NSTimeInterval max = 0;
    
    for (WGResult *result in log.results) {
        if (result.success) {
            successes++;
        } else {
            failures++;
        }
        
        average += result.responseTime;
        max = MAX(max, result.responseTime);
    }
    
    average = average / log.results.count;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%0.0f%%/%0.2fsec/%0.2fsec)", log.SSID, successes*100.0/(successes+failures), average, max];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark -

- (WGLog *)logForIndexPath:(NSIndexPath *)indexPath {
    WGLog *log;
    
    id a = self.logs[indexPath.row];
    if ([a isKindOfClass:[WGLog class]]) {
        log = self.logs[indexPath.row];
    } else {
        log = [WGLog newLogFromContentsFile:a];
        [self.logs replaceObjectAtIndex:indexPath.row withObject:log];
    }
    
    return log;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailOpen"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        WGLog *log = [self logForIndexPath:indexPath];
        
        LogDetailViewController *vc = segue.destinationViewController;
        vc.log = log;
    }
}

- (IBAction)addLogCancel:(UIStoryboardSegue *)segue {
}

- (IBAction)addLogDone:(UIStoryboardSegue *)segue {
    AddNewLogViewController *vc = segue.sourceViewController;
    WGLog *newLog = vc.log;
        
    [self.logs insertObject:newLog atIndex:0];
    [self.tableView reloadData];
    
    NSString *filename = [self.fileNameFormatter stringFromDate:newLog.timestamp];
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    [newLog save:[dir stringByAppendingPathComponent:filename]];
}

@end
