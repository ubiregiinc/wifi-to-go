//
//  LogsTableViewController.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/20.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogsTableViewController : UITableViewController

- (IBAction)addLogCancel:(UIStoryboardSegue *)segue;
- (IBAction)addLogDone:(UIStoryboardSegue *)segue;

@end
