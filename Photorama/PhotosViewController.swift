//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Shubh Patel on 2019-03-14.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos() {
            
             (photosResult) -> Void in
        
        switch photosResult {
        case let .success(photos):
            print("Successfully found \(photos.count) photos.")
        case let .failure(error):
            print("Error fetching photos: \(error)")
            
            }
        }
    }
        
}
