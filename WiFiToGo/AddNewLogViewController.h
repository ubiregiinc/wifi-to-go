//
//  AddNewLogViewController.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/20.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "AppDelegate.h"
#import "WGLog.h"

@interface AddNewLogViewController : UIViewController<CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *hostnameTextField;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *resultImageViews;

@property (nonatomic, strong) WGLog *log;

- (IBAction)testButtonTap:(id)sender;
- (IBAction)photoButtonTap:(id)sender;
- (IBAction)saveButtonTap:(id)sender;

@end
