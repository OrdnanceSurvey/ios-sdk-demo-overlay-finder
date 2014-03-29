//
//  OSOverlayFactory.h
//  OSOverlayFinder
//
//  Created by rob murray on 29/03/2014.
//  Copyright (c) 2014 OrdnanceSurvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OSMap/OSMap.h>

@interface OSOverlayFactory : NSObject

/**
 * Create a OSPolyline in a random location with the 
 *  specified number of points and a max distance between points
 */
+(OSPolyline*) polylineWith:(double)maxDelta andPoints:(int)pointsCount;

/**
 * Create a OSPolygon in a random location with the 
 *  specified number of points and a max distance between points
 */
+(OSPolygon*) polygonWith:(double)maxDelta andPoints:(int)pointsCount;

/**
 * Create a OSPolygon with 4 points and sides of equal length
 */
+(OSPolygon*) squareWith:(double)length;

/**
 * Create a OSCircle in a random location with the 
 *  specified number radius
 */
+(OSCircle*) circleWith:(double)radius;

/**
 * Generate a OSGridPoint {e,n} within the specified OSGridRect
 */
+(OSGridPoint) randomGridPointWithin:(OSGridRect)gridRect;

@end
