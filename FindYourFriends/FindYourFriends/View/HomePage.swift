//
//  HomePage.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import UIKit
import CoreLocation
import MapKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    // Creation of a my information profile
    //TODO: Creation of an onboarding process to get the data from the user.
    var mydata: Friend = Friend(id: 0,
                                name: "Giuseppe Diciolla",
                                lat: "-1",
                                lng: "-1")
    var friends: [Friend] = []
    var locationManager = CLLocationManager()
    @IBOutlet weak var friendsTV: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func `switch`(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            friendsTV.alpha = 1
            mapView.alpha = 0
        } else {
            friendsTV.alpha = 0
            mapView.alpha = 1
        }
    }
    
    let coordUtil = CoordinateUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        // my data
        mydata.name = "Giuseppe Diciolla"
        mydata.street = "Via molisana 30F 50593 Montecatini"
        mydata.phone = "+39 334 8839405"
        
        // get current position of the user on the moment he open the app
        //TODO: adapt the get location request with the new location privacy guideline of Apple released with iOS 14
        
        do {
            locationManager.requestWhenInUseAuthorization()
            var currentLoc: CLLocation!
            if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
                currentLoc = locationManager.location
                self.mydata.lat = String(currentLoc.coordinate.latitude)
                self.mydata.lng = String(currentLoc.coordinate.longitude)
                print(currentLoc.coordinate.latitude)
                print(currentLoc.coordinate.longitude)
            }
        } catch {}
        
        // Get data from URL and mapp them into a list of Friend Obj
        //TODO: a real Api, that gives you the firend list, and updates when some other friends where added
        let url = "https://jsonplaceholder.typicode.com/users"
        let dataReciver: DataReciver = DataReciver()
        friends = [Friend]()
        dataReciver.getUserData(urlString: url, context: self)
        
    }
    
    func updateTable(data: [Friend]){
        self.friends = data
        friends = friends.sorted { (fr1: Friend, fr2: Friend) -> Bool in
            return fr1.distance < fr2.distance
        }
        
        addMarkersOnMap()
        
        DispatchQueue.main.async{
            self.friendsTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomFriendTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let friend = friends[indexPath.row]
        
        cell.friendName.text = friend.name
        cell.navigateToFriendButton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.navigateToFriendButton.tag = indexPath.row
        
        cell.friendDistanceToYou.text = String(format: "%.2f", friend.distance) + " Km from you"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailCardSegue", sender: self)
    }
    
    func addMarkersOnMap(){
        // ADD MARKERS ON MAPP
        // TODO: Implement a cardlist that let you chance the pins by scrolling orizontally, like google maps with restaurants
        var index = 0
        for frnd in self.friends {
            do {
                let location = CLLocationCoordinate2D(latitude: Double(frnd.lat)!,
                                                    longitude: Double(frnd.lng)!)
                
                // 2
                if index == 0 {
                    let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                    let region = MKCoordinateRegion(center: location, span: span)
                    mapView.setRegion(region, animated: true)
                }
                //3
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = frnd.name
                self.mapView.addAnnotation(annotation)
            } catch {}
            index = index + 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailCard
        vc.detailData = friends[friendsTV.indexPathForSelectedRow!.row]
    }
    
    @objc func connected(sender: UIButton){
        MappUtil.goToMap(venueLat: friends[sender.tag].lat as NSString,
                         venueLng: friends[sender.tag].lng as NSString,
                         label: friends[sender.tag].name)
    }
}
