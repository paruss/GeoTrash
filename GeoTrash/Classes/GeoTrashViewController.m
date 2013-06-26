//
//  GeoTrashViewController.m
//  GeoTrash
//
//  Created by Patrick Russell on 22/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GeoTrashViewController.h"
#import "MapViewController.h"
#import "Annotation.h"
#import "AnnotationViewController.h"
#import "ASINetworkQueue.h"

enum
{
    kAnnotationIndex = 10,
};

@implementation GeoTrashViewController


@synthesize currentImage, sentPhoto, takePhoto, lat, lon, CLController, mapAnnotations, mapView, annotationViewController, cacher, imageView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
	CLController = [[Location alloc] init];
	CLController.delegate = self;
	[CLController.locMgr startUpdatingLocation];
    [super viewDidLoad];
	

}

- (void)viewDidAppear:(BOOL)animated
{
    // bring back the toolbar
    [self.navigationController setToolbarHidden:NO animated:NO];
	
	
	// If an image has been taken display the view to select to upload it or not.
	
	if (currentImage != nil)
	{
		
		ImageView *imgView = [[ImageView alloc] initWithNibName:@"ImageViewController" bundle:nil];
		
		[self.view.superview addSubview:imgView.view];	
		imgView.theImageView.image = currentImage;
		[self.navigationController setToolbarHidden:YES animated:NO];
		
	}
	
	}


- (IBAction)sentGPS:(id)sender{
	
	NSURL *url;
	NSMutableURLRequest * request;

	request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	
}


-(IBAction) loadMap:(id) sender{
	
	//display a map on screen load to current positon and display pins.
	
    [super viewDidLoad];
	mapView=[[MKMapView alloc] initWithFrame:self.view.frame];
	mapView.showsUserLocation=TRUE;
	mapView.delegate=self;
	[self.view insertSubview:mapView atIndex:2];
	CLLocationManager *locationManager=[[CLLocationManager alloc] init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
    
	cacher = [[Cacher alloc]init];
	
	//////Not Sure what this does but breaks code fix later////////////
	
/*	id number;
//	number = self.cacher;

//	[number dbToArray];
	//[cacher checkAndCreateDatabase];
	
	
	[number buildDatabaseFromRemoteData];
	//////////////Fucked///////////////////////////*/
    // create out annotations array (in this example only 2)
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:1];
    
    // annotation for the City of San Francisco
    Annotation *annotation = [[Annotation alloc] init];
    [self.mapAnnotations insertObject:annotation atIndex:0];
	[self.mapView addAnnotation:[self.mapAnnotations objectAtIndex:0]];
    [annotation release];
	
}

- (void)showDetails:(id)sender
{
	
	AnnotationViewController *annotation= [[AnnotationViewController alloc] initWithNibName:@"AnnotationViewController" bundle:nil];
	[self.view.superview addSubview:annotation.view];

}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[Annotation class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
    
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}


-(IBAction) remMap:(id) sender{
	

[mapView removeFromSuperview];
	

}
- (void)locationUpdate:(CLLocation *)location {
//	locLabel.text = [location description];
	self.lat = [[NSString alloc]init];
	NSString *locLat;
	NSString *locLong;
	locLat  = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
	locLong  = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
	self.lat = locLat;
	self.lon = locLong;
	
	
}

- (void)locationError:(NSError *)error {
//	locLabel.text = [error description];
}

 
-(IBAction) getPhoto:(id) sender{
	
	// load the image picker view
	imageView = [[ImageView alloc] initWithNibName:@"ImageViewController" bundle:nil];
	[self.navigationController pushViewController:imageView animated:YES];	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if((UIButton *) sender == sentPhoto) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	 
	//make visable
	[self presentModalViewController:picker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	//Remove the picker
	[picker dismissModalViewControllerAnimated:YES];
	picker.view.hidden = YES;
	
	// Set the image for the image view and set the toolbar to be hidden
	UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	imageView.theImageView.image = img;
	[self.navigationController setToolbarHidden:YES animated:NO];	
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	
	[picker dismissModalViewControllerAnimated:YES];
	// Remove the image view which was loaded as it would appear when cancel is selected
	[self.navigationController popViewControllerAnimated: NO];
}


- (IBAction)populateLocationList:(id)sender
{
	cacher = [[Cacher alloc]init];
	id number;
	
	//[number locationsArray];	
	
	number = self.cacher;
    [number buildDatabaseFromRemoteData];
	
}

- (IBAction)loadFromDB:(id)sender
{
	cacher = [[Cacher alloc]init];
	id number;
	
	number = self.cacher;
	
	// Get the path to the documents directory and append the databaseName

	[number dbToArray];
		
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
}

@end
