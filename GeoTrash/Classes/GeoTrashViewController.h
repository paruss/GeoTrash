//
//  GeoTrashViewController.h
//  GeoTrash
//
//  Created by Patrick Russell on 22/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"

#import "MapViewController.h"
#import "MapModel.h"
#import "MapModel.m"
#import "GeoTrashAppDelegate.h"
#import "Cacher.h"
#import "ImageView.h"

@class AnnotationViewController;

@interface GeoTrashViewController : UIViewController  < UIImagePickerControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate,NSNetServiceBrowserDelegate  > {
	
	UIImage * currentImage;
	UIButton * takePhoto;
	MKMapView *mapView;
	NSString *lat;
	NSString *lon;
	Location *CLController;
	NSMutableArray *mapAnnotations;
	NSString *databaseName;
	NSString *databasePath;
	AnnotationViewController *annotationViewController;
	Cacher *cacher;
	ImageView *imageView;


}

@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) IBOutlet UIImage * currentImage;
@property (nonatomic, retain) IBOutlet UIButton * sentPhoto;
@property (nonatomic, retain) IBOutlet UIButton * takePhoto;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) Location *CLController;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet AnnotationViewController *annotationViewController;
@property (nonatomic, retain) Cacher *cacher;
@property (nonatomic, retain) ImageView *imageView;



- (IBAction)loadMap:(id)sender;
- (IBAction)sentGPS:(id)sender;
- (IBAction)populateLocationList:(id)sender;
- (IBAction)loadFromDB:(id)sender;
- (IBAction) remMap:(id) sender;


@end

