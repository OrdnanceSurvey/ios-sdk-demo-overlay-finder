//
//  ViewController.h
//  OSOverlayFinder
//
//  Created by rmurray on 16/01/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OSMap/OSMap.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet OSMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;

- (IBAction)segmentValueChanged:(id)sender;

@end
