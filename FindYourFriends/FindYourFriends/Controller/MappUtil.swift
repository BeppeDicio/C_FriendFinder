//
//  MappUtil.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 02/10/2020.
//

import Foundation
import MapKit

class MappUtil {
    
    static func goToMap(venueLat: NSString, venueLng: NSString, label: String){

        let lat1 : NSString = venueLat
        let lng1 : NSString = venueLng

        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue

        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)

        let mapItem:MKMapItem = MKMapItem(placemark: placemark)

        mapItem.name = label

        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)

        let currentLocationMapItem:MKMapItem = MKMapItem.forCurrentLocation()

        MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : Any])

    }
}
