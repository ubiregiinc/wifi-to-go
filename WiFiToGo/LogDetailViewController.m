//
//  LogDetailViewController.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "LogDetailViewController.h"

@interface LogAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@end

@implementation LogAnnotation

@end

@interface LogDetailViewController ()

@end

@implementation LogDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.mapView.hidden = NO;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.log.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    LogAnnotation *an = [LogAnnotation new];
    an.coordinate = self.log.location.coordinate;
    an.title = self.log.SSID;
    
    [self.mapView addAnnotation:an];
    
    self.imageView.hidden = YES;
    self.imageView.image = self.log.image;
}

- (IBAction)segmentChanged:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.imageView.hidden = YES;
        self.mapView.hidden = NO;
    } else {
        self.imageView.hidden = NO;
        self.mapView.hidden = YES;
    }
}

@end
