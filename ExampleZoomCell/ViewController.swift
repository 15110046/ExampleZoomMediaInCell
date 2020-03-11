//
//  ViewController.swift
//  ExampleZoomCell
//
//  Created by Azibai on 11/03/2020.
//  Copyright © 2020 Azibai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let identifierCell = "MediaCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewIsReady()
        regitstNotificationCenter()
    }
    
    func viewIsReady() {
        collectionView.register(UINib(nibName: identifierCell, bundle: nil), forCellWithReuseIdentifier: identifierCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func regitstNotificationCenter() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setScrollDisable),
                         name: NSNotification.Name.CellisZooming, object: nil)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setScrollEnabled),
                         name: NSNotification.Name.CellStopZoom, object: nil)
    }
    
    @objc func setScrollEnabled() {
        collectionView.isScrollEnabled = true
    }
    @objc func setScrollDisable() {
        collectionView.isScrollEnabled = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.CellisZooming, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.CellStopZoom, object: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}


