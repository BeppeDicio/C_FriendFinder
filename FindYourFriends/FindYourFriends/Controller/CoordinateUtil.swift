//
//  CoordinateUtil.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import CoreLocation

class CoordinateUtil {
    
    func getDistanceKm(myLat: Double, myLng: Double, friendsLat: Double, friendsLng: Double) -> Double{
        
        let myCoordinate = CLLocation(latitude: myLat, longitude: myLng)
        let frdCoordinate = CLLocation(latitude: friendsLat, longitude: friendsLat)

        let distanceInMeters = myCoordinate.distance(from: frdCoordinate)
        
        return distanceInMeters/1000
    }
}
