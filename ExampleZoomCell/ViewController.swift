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
    }
    
    func viewIsReady() {
        collectionView.register(UINib(nibName: identifierCell, bundle: nil), forCellWithReuseIdentifier: identifierCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    deinit {}
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
        return CGSize(width: (collectionView.frame.width-10)/2, height: 300)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {}


