//
//  ViewController.m
//  OSOverlayFinder
//
//  Created by rmurray on 16/01/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import "MapViewController.h"
#import "OSOverlayFactory.h"


/*
 * Define your OS Openspace API KEY details below
 * @see http://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/index.html
 */
static NSString *const kOSApiKey = @"E2BE1E5D602A3BF3E0430B6CA40ACE3B";
static BOOL const kOSIsPro = NO;

/*
 * Define a basic game level structure
 */
typedef enum{
    EASY = 0,
    MEDIUM,
    HARD
} GameDifficultyLevel;


@interface MapViewController () <OSMapViewDelegate>

@end


@implementation MapViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
	
    {
        //create web tile source with API details
        id<OSTileSource> webSource = [OSMapView webTileSourceWithAPIKey:kOSApiKey openSpacePro:kOSIsPro];
        _mapView.tileSources = [NSArray arrayWithObjects:webSource, nil];
        
        [_mapView setDelegate:self];
        
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [_mapView setRegion: OSCoordinateRegionForGridRect(OSNationalGridBounds)];
        
        NSLog(@"Using SDK Version: %@",[OSMapView SDKVersion]);
    }
    
    // Add UITapGestureRecognizer to detect Overlay touches
    [_mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)]];
    
    
    /*
     * Simple method of showing instructions on the first run of this app on each device 
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if( ![defaults objectForKey:@"firstRun"] ) {
        
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions:"
                                                        message:@"Tap on all overlays to complete the game"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
        [alert show];
        
    }

    /*
     * Create new game
     */
    [self createNewGameForLevel: EASY];
}



- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark -
#pragma mark Game methods

/*
 * Initiate a new game with the difficulty level passed
 */
-(void) createNewGameForLevel:(GameDifficultyLevel)level {
    
    [_mapView removeOverlays:_mapView.overlays];
    
    static int polygonPointsCount = 4;
    
    /*
     * For the game difficulties we simply adjust the size of each overlay,
     *  smaller = harder
     */
    double squareSideLen;
    double circleRadius;
    double polyPointsDelta;
    
    // Simply adjust the size of overlays
    switch (level) {
            
        case EASY:
            squareSideLen = 100000;
            circleRadius = 20000;
            polyPointsDelta = 100000;
            break;
            
        case MEDIUM:
            squareSideLen = 10000;
            circleRadius = 2000;
            polyPointsDelta = 10000;
            break;
            
        case HARD:
            squareSideLen = 1000;
            circleRadius = 200;
            polyPointsDelta = 1000;
            break;
    }
    
    [_mapView addOverlay:[OSOverlayFactory squareWith: squareSideLen]];
    
    [_mapView addOverlay: [OSOverlayFactory circleWith: circleRadius]];
    
    [_mapView addOverlay:[OSOverlayFactory polygonWith: polyPointsDelta andPoints: polygonPointsCount]];
    
    [_mapView addOverlay:[OSOverlayFactory polylineWith: polyPointsDelta andPoints: polygonPointsCount]];
    
    [self updateScoreLabel];
}


/*
 * Update the UI Label with the score (overlays count)
 */
-(void) updateScoreLabel {
    
    int count = [_mapView.overlays count];
    
    if( count == 1 ){
        
        [self.scoreLbl setText:[NSString stringWithFormat:@"%i overlay remaining", count]];
        
    }else{
        
        [self.scoreLbl setText:[NSString stringWithFormat:@"%i overlays remaining", count]];
        
    }
    
}

/*
 * return a random color - used for overlay styling
 */
-(UIColor *) randomColorWithAlpha:(float)alpha {
    
    return [UIColor colorWithRed:((float)rand() / RAND_MAX)
                           green:((float)rand() / RAND_MAX)
                            blue:((float)rand() / RAND_MAX)
                           alpha:alpha];
}


#pragma mark -
#pragma mark IBAction and UIGesture methods

/*
 * Action performed after an overlay has been tapped
 */
-(void) overlayTapped: (id<OSOverlay>)overlay {
    
    [_mapView removeOverlay: overlay];
    [self updateScoreLabel];
    
    if( [_mapView.overlays count] == 0 ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                        message:@"You have found all overlays!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction) segmentValueChanged:(id)sender {
    
    int index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    
    NSLog(@"%s - SelectedIndex: %i",__PRETTY_FUNCTION__, index);

    [self createNewGameForLevel: index];
}

/*
 * Handle each UITapGestureRecognizer and determine which, if any, Overlay has been tapped
 */
- (void) mapTapped:(UITapGestureRecognizer *)recognizer {
    
    id<OSOverlay> tappedOverlay = nil;
    
    //iterate through overlays
    for ( id<OSOverlay> overlay in _mapView.overlays ) {
        
        //Check if each Overlay is in current view
        OSOverlayView *view = [_mapView viewForOverlay:overlay];
        if ( !view ) {
            
            continue;
            
        }

            
        // Grab the overlay view frame rect from mapView
        CGRect viewFrame = [view.superview convertRect:view.frame toView:_mapView];
            
        // Get touch point in the mapView's coordinate system
        CGPoint touchPoint = [recognizer locationInView:_mapView];
            
        //
        // If the touched point is in view's CGRect then it is the one tapped
        // NOTE: As this only checks if the touch point is in the CGRect, any taps outside
        //    the overlay are handled.
        //   It also only takes the first overlay in mapView's array if any overlap
        //
        if ( CGRectContainsPoint(viewFrame, touchPoint) ) {
            
            tappedOverlay = overlay;
            break;
            
        }
    }
    
    if( tappedOverlay ) {
        
        [self overlayTapped:tappedOverlay];
        
    }
    
}

#pragma mark -
#pragma mark OSMapViewDelegate methods


-(OSOverlayView *) mapView:(OSMapView *)mapView viewForOverlay:(id<OSOverlay>)overlay {

    /*
     * Style each type of overlay
     */
    
    if ( [overlay isKindOfClass:[OSCircle class]] ) {

        OSCircleView * view = [[OSCircleView alloc] initWithCircle:(id)overlay];

        view.lineWidth = 1;
        view.strokeColor = [self randomColorWithAlpha:1.0f];
        view.fillColor = [self randomColorWithAlpha:0.5f];
        view.userInteractionEnabled = YES;
        
        
        return view;
    }
    
    if ( [overlay isKindOfClass:[OSPolygon class]] ) {
        
        OSPolygonView * view = [[OSPolygonView alloc] initWithPolygon:(id)overlay];
        
        view.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:4], [NSNumber numberWithFloat:4], nil];
        view.lineWidth = 1;
        view.strokeColor = [self randomColorWithAlpha:1.0f];
        view.fillColor = [self randomColorWithAlpha:0.5f];
        
        return view;
    }
    
    if ( [overlay isKindOfClass:[OSPolyline class]] ) {
        
        OSPolylineView * view = [[OSPolylineView alloc] initWithPolyline:(id)overlay];
        
        view.lineWidth = 5;
        view.strokeColor = [self randomColorWithAlpha:1.0f];
        view.fillColor = [self randomColorWithAlpha:0.5f];
        
        return view;
    }
    
    return nil;
}


@end
