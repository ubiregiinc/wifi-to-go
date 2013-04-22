//
//  LogDetailViewController.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "WGLog.h"

@interface LogDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)segmentChanged:(id)sender;

@property (nonatomic, strong) WGLog *log;

@end
