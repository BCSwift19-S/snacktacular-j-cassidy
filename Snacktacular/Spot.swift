//
//  Spot.swift
//  Snacktacular
//
//  Created by James Cassidy on 4/1/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

class Spot {
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Double
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var latitude: CLLocationDegrees {
        return coordinate.latitude
    }
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address, "longitude": longitude, "latitude": latitude, "averageRating": averageRating, "numberOfReviews": numberOfReviews, "postingUserID": postingUserID]
    }
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D, averageRating: Double, numberOfReviews: Int, postingUserID: String, documentID: String) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentID = documentID
        
    }
    
    convenience init() {
        self.init(name: "", address: "", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        //grab user id
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("^^^^ couldnt save data cuz didnt have a valid postinguserid")
            return completed(false)
        }
        self.postingUserID = postingUserID
        
        //create dictionary representing data to save
        let dataToSave = self.dictionary
        
        //if we have saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("spots").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** error: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("Document updated with ref id \(ref.documentID))")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil
            ref = db.collection("spots").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** error: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("new document created with ref id \(ref?.documentID ?? "unknown"))")
                    completed(true)
                }
            }
        }
    }
    
}
