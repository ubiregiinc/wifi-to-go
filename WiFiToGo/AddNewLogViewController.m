//
//  AddNewLogViewController.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/20.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "AddNewLogViewController.h"

#import "UIImage+UB.h"

@interface AddNewLogViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation AddNewLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.hostnameTextField.delegate = self;
    
    self.saveButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.lastLocation = [locations lastObject];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002, 0.002);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.lastLocation.coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.photo = info[UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(self.photo, nil, nil, nil);
    
    self.photo = [self.photo imageResizedToFitRectangle:CGSizeMake(800, 800)];
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{}];
    self.imagePicker = nil;
    
    self.photoImageView.image = self.photo;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -

- (void)runTest:(void(^)(NSUInteger, WGResult *))progress completion:(void(^)())completion {
    dispatch_queue_t queue = dispatch_queue_create("hogehoge", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            NSURL *url = [NSURL URLWithString:self.hostnameTextField.text];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setTimeoutInterval:10];
            
            NSDate *startDate = [NSDate date];
            
            NSURLResponse *response;
            NSError *error;
            [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSDate *endDate = [NSDate date];
            
            WGResult *result = [[WGResult alloc] init];
            result.success = [(NSHTTPURLResponse *)response statusCode] == 200;
            result.responseTime = [endDate timeIntervalSinceDate:startDate];
            result.message = [error debugDescription];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(i, result);
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), completion);
    });
}

- (IBAction)testButtonTap:(id)sender {
    NSMutableArray *results = [NSMutableArray new];
    
    for (UIImageView *iv in self.resultImageViews) {
        iv.image = nil;
    }
    
    self.testButton.enabled = NO;
    self.saveButton.enabled = NO;
    
    [self runTest:^(NSUInteger index, WGResult *result) {
        UIImageView *iv = self.resultImageViews[index];
        
        if (result.success) {
            iv.image = [UIImage imageNamed:@"extension_connect_ok"];
        } else {
            iv.image = [UIImage imageNamed:@"extension_connect_power"];
        }
     
        [results addObject:result];
    } completion:^{
        self.testButton.enabled = YES;
        self.saveButton.enabled = YES;

        self.log = [WGLog new];
        self.log.timestamp = [NSDate date];
        self.log.SSID = self.appDelegate.currentConnectedSSID;
        self.log.image = self.photo;
        self.log.location = self.lastLocation;
        self.log.hostname = self.hostnameTextField.text;
        self.log.results = results;
    }];
}

- (IBAction)photoButtonTap:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.delegate = self;
    
    [self presentViewController:self.imagePicker animated:YES completion:^{}];
}

- (IBAction)saveButtonTap:(id)sender {
    if (self.log) {
        self.log.image = self.photo;
        [self performSegueWithIdentifier:@"done" sender:self];
    }
}

@end
