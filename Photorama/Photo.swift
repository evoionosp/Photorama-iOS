//
//  Photo.swift
//  Photorama
//
//  Created by Shubh Patel on 2019-03-14.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
        
    }
    
    
}
