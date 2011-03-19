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
@synthesize theImageView;
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
    [super viewDidLoad];
}

- (IBAction)upload:(id)sender
{ 
	
	
	
	NSURL *url = [NSURL URLWithString:@"http://www.skynet.ie/~paruss/iPhone/test-upload.php"];
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];	
	
	NSData *compressedImageData = UIImageJPEGRepresentation(theImageView.image, 0.5f);
	
	//[request setFile:jpgPath forKey:@"photo"];
	[request setFile:compressedImageData withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
	//[request setPostData:@"test" forKey];
	//[request setFile]

	[request setDelegate:self];
	[request startAsynchronous];
	
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSLog(@"Response: %@", responseString);
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
