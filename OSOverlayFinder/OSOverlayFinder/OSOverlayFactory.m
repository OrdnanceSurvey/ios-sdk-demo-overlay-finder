//
//  OSOverlayFactory.m
//  OSOverlayFinder
//
//  Created by rob murray on 29/03/2014.
//  Copyright (c) 2014 OrdnanceSurvey. All rights reserved.
//

#import "OSOverlayFactory.h"

@interface OSOverlayFactory()

+(OSGridRect) gameMapGridRectForDelta:(double)maxDelta;

@end

@implementation OSOverlayFactory

/**
 * Add an inset around NatGrid bounds so overlays don't
 *  shoot off outside the map too much
 */
+(OSGridRect) gameMapGridRectForDelta:(double)maxDelta {
    
    return OSGridRectInset(OSNationalGridBounds, maxDelta, maxDelta);
    
}


+(OSPolyline*) polylineWith:(double)maxDelta andPoints:(int)pointsCount {
    
    // generate the start point and then the OSGridRect this will sit in
    OSGridRect gameCanvas = [OSOverlayFactory gameMapGridRectForDelta: maxDelta];
    OSGridPoint startPoint = [OSOverlayFactory randomGridPointWithin: gameCanvas];
    OSGridRect polyGridRect = OSGridRectMake(startPoint.easting, startPoint.northing, maxDelta, maxDelta);
    
    // generate n random points
    OSGridPoint points[pointsCount];
    for( int x = 0; x < pointsCount; x++ ) {
        
        points[x] = [OSOverlayFactory randomGridPointWithin: polyGridRect];
        
    }
    
    return [OSPolyline polylineWithGridPoints:points count:pointsCount];
    
}

+(OSPolygon*) polygonWith:(double)maxDelta andPoints:(int)pointsCount {
    
    // generate the start point and then the OSGridRect this will sit in
    OSGridRect gameCanvas = [OSOverlayFactory gameMapGridRectForDelta: maxDelta];
    OSGridPoint startPoint = [OSOverlayFactory randomGridPointWithin: gameCanvas];
    OSGridRect polyGridRect = OSGridRectMake(startPoint.easting, startPoint.northing, maxDelta, maxDelta);
    
    // generate n random points
    OSGridPoint points[pointsCount];
    for( int x = 0; x < pointsCount; x++ ) {
        
        points[x] = [OSOverlayFactory randomGridPointWithin: polyGridRect];
        
    }
    
    return [OSPolygon polygonWithGridPoints:points count:pointsCount];
    
}

+(OSPolygon*) squareWith:(double)length {
    
    OSGridRect gameCanvas = [OSOverlayFactory gameMapGridRectForDelta: length];
    OSGridPoint sw = [OSOverlayFactory randomGridPointWithin: gameCanvas];
    
    // array of 4 corners
    OSGridPoint points[] = {{sw.easting,sw.northing},
        {sw.easting+length,sw.northing},
        {sw.easting+length,sw.northing+length},
        {sw.easting,sw.northing+length}};
    
    return [OSPolygon polygonWithGridPoints: points count: 4];
    
}

+(OSCircle*) circleWith:(double)radius {
    
    OSGridRect gameCanvas = [OSOverlayFactory gameMapGridRectForDelta: radius];
    CLLocationCoordinate2D centre = OSCoordinateForGridPoint([OSOverlayFactory randomGridPointWithin: gameCanvas]);
    
    return [OSCircle circleWithCenterCoordinate:centre radius: radius];
    
}

+(OSGridPoint) randomGridPointWithin:(OSGridRect)gridRect {
    
    int minx = gridRect.originSW.easting;
    int maxx = gridRect.originSW.easting + gridRect.size.width;
    int x = minx + arc4random() % (maxx - minx);
    
    int miny = gridRect.originSW.northing;
    int maxy = gridRect.originSW.northing + gridRect.size.height;
    int y = miny + arc4random() % (maxy - miny);
    
    return ((OSGridPoint){x,y});
    
}

@end
