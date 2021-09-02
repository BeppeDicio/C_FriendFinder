//
//  DetailCard.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import UIKit
import MapKit

class DetailCard: UIViewController{
    
    @IBOutlet weak var nomeutente: UILabel!
    @IBOutlet weak var callCTA: UIButton!
    @IBOutlet weak var navigateCTA: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userStreet: UILabel!
    @IBAction func closeB(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    var detailData: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        // MAPPVIEW SETUP
        // 1
        let location = CLLocationCoordinate2D(latitude: Double(detailData!.lat)!,
                                            longitude: Double(detailData!.lng)!)
        
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = detailData?.name
        mapView.addAnnotation(annotation)
        
        // END MAPPVIEW SETUP
        
        nomeutente.text = detailData?.name
        
        // TODO: Create streetString from db that gives a formatted street string
        // so that on front-end it is not needed to make to much controlls on the single objs
        userStreet.text = detailData?.street
        
        
        // BUTTON SET UP
        callCTA.layer.cornerRadius = 25
        navigateCTA.layer.cornerRadius = 25
        callCTA.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        navigateCTA.addTarget(self, action: #selector(mapAction), for: .touchUpInside)
        
    }
    
     @objc func callAction(sender: UIButton!) {
        let formattedNumber = detailData?.phone!.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")

        if let url = NSURL(string: ("tel:" + (formattedNumber)!)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
        print("Button tapped")
     }
    
    @objc func mapAction(sender: UIButton!) {
        
        MappUtil.goToMap(venueLat: detailData!.lat as NSString, venueLng: detailData!.lng as NSString, label: detailData!.name)
        
        print("Button tapped")
    }
}
