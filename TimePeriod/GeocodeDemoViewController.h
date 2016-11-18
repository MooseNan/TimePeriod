//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface GeocodeDemoViewController : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate> {
	IBOutlet BMKMapView* _mapView;
	BMKGeoCodeSearch* _geocodesearch;
}
@property(nonatomic,strong) NSString *area;
@end
