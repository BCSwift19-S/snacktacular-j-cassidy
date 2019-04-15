//
//  Photo.swift
//  Snacktacular
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 Jimmy Cassidy. All rights reserved.
//

import Foundation
import Firebase

class Photo {
    var image: UIImage
    var description: String
    var postedBy: String
    var date: Date
    var documentUUID: String //universal unique identifer
    
    init(image: UIImage, description: String, postedBy: String, date: Date, documentUUID: String) {
        self.image = image
        self.description = description
        self.postedBy = postedBy
        self.date = date
        self.documentUUID = documentUUID
    }
    
}
