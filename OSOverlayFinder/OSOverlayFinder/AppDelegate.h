//
//  AppDelegate.h
//  OSOverlayFinder
//
//  Created by rmurray on 16/01/2013.
//  Copyright (c) 2013 OrdnanceSurvey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MapViewController *viewController;

@end
