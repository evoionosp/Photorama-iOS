//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Shubh Patel on 2019-03-14.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UISearchResultsUpdating {

    
    @IBOutlet var collectionView: UICollectionView!
 
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    var searchContoller: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource  = photoDataSource
        collectionView.delegate = self
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        searchContoller = UISearchController(searchResultsController: nil)
        searchContoller?.searchResultsUpdater = self
        navigationItem.searchController = searchContoller
        navigationItem.hidesSearchBarWhenScrolling = false
        loadAllPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo){ (result) -> Void in
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else{
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                cell.update(with: image)
            }
        }
    }
    
    func filterContent(searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        print(searchText)
        searchPhotos(searchText: searchText)
    }
    
    // MARK: - UISearchResultsUpdating method
    
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            if(searchText.isEmpty || searchText == ""){
                loadAllPhotos()
            } else {
                searchPhotos(searchText: searchText)
            }
        } else {
            loadAllPhotos()
        }
    }
    
    func loadAllPhotos() {
        store.fetchInterestingPhotos() {
            
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                /*  if let firstPhoto = photos.first {
                 self.updateImageView(for: firstPhoto)
                 } */
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching photos: \(error)")
                self.photoDataSource.photos.removeAll()
                
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func searchPhotos(searchText: String) {
        store.fetchInterestingPhotos(search: searchText) {
            
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                /*  if let firstPhoto = photos.first {
                 self.updateImageView(for: firstPhoto)
                 } */
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching photos: \(error)")
                self.photoDataSource.photos.removeAll()
                
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    
}
