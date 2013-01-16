//
//  ViewController.m
//  OSOverlayFinder
//
//  Created by rmurray on 16/01/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import "MapViewController.h"


/*
 * Define your OS Openspace API KEY details below
 * @see http://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/index.html
 */
static NSString *const kOSApiKey = @"YOUR_KEY_HERE";
static NSString *const kOSApiKeyUrl = @"YOUR_API_URL_HERE";
static BOOL const kOSIsPro = YES;
static NSString *const kOSSearchDBFilename = @"YOUR_FILENAME_HERE.ospoi";


@interface MapViewController () <OSMapViewDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey refererUrl:kOSApiKeyUrl openSpacePro:kOSIsPro];
        _mapView.tileSources = [NSArray arrayWithObjects:webSource, nil];
        
        [_mapView setDelegate:self];
        
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        NSLog(@"Using SDK Version: %@",[OSMapView SDKVersion]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark IBAction methods

- (IBAction)segmentValueChanged:(id)sender {
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
}




@end
