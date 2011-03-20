//
//  ImageView.m
//  GeoTrash
//
//  Created by Patrick Russell on 15/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"
#import "ASIFormDataRequest.h";
#import "ASINetworkQueue.h"

@implementation ImageView
@synthesize theImageView, lat, lon, CLController, myActivityIndicator;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	CLController = [[Location alloc] init];
	CLController.delegate = self;
	[CLController.locMgr startUpdatingLocation];
    [super viewDidLoad];
}

- (IBAction)upload:(id)sender
{ 

	// Display the activity indicator 
	[myActivityIndicator startAnimating];
	//Set up variables and copy image into NSData compressed
	srandom(time(NULL));
	NSURL *url = [NSURL URLWithString:@"http://www.skynet.ie/~paruss/iPhone/test-upload.php"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];	
	NSData *compressedImageData = UIImageJPEGRepresentation(theImageView.image, 0.5f);
	
	//set the filename to a random number
	
	int randomNumber = (random() % 250000);
	NSString* fileName = [NSString stringWithFormat:@"%d.jpg", randomNumber];
	
	
	// Set the filename and upload
	
	[request setFile:compressedImageData withFileName:fileName andContentType:@"image/jpeg" forKey:@"photo"];
	[request setDelegate:self];
	[self Update:fileName];
	
	//Create a location manager and start it uploading (delegate : Location update)
	
	CLLocationManager *locationManager=[[CLLocationManager alloc] init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	
	[request startAsynchronous];
	
}

- (void)locationUpdate:(CLLocation *)location {
	
	// Delegate of startUpdatingLocation
	// Get the current location and save them
	
	self.lat = [[NSString alloc]init];
	NSString *locLat;
	NSString *locLong;
	locLat  = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
	locLong  = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
	self.lat = locLat;
	self.lon = locLong;
}


- (void)requestFinished:(ASIHTTPRequest *)request {
	
	// When request is finished display an alert to show the user that the file has been uploaded and finally remove the image view.
	
	[myActivityIndicator stopAnimating];
	NSString *responseString = [request responseString];
	NSLog(@"Response: %@", responseString);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uploaded" message:@"Your Image Has Been Uploaded"  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"OK", nil];
	[alert show];
	[alert release];
	[self.navigationController popViewControllerAnimated: NO];
}

/*
- (IBOutlet)myActivityIndicator:(id)sender{
	
	
}
*/


- (void)Update:(NSString *)imgLink
{
	// Store the required variables
	
	NSString *latPost = self.lat;
	NSString *lonPost = self.lon;
	NSURL *url = [NSURL URLWithString:@"http://www.skynet.ie/~paruss/iPhone/Uploader.php"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	// Set the requests sending the values latitude longitude and the link to the image. Then start the request
	
	[request setPostValue:lonPost forKey:@"lon"];
	[request setPostValue:latPost forKey:@"lat"];
	[request setPostValue:imgLink forKey:@"img"];
	[request start]; 

	// If there is an error display 
	
	NSError *error = [request error];
	if (!error) {
		
		NSString *response = [request responseString];
		NSLog(@"Output", response);
		
	}
}

-(void)locationError:(NSError *)error{
	
	NSLog(@"Problem with uploading");
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.theImageView = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
