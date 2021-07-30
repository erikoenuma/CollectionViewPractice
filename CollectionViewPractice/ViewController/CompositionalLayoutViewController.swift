//
//  CompositionalLayoutViewController.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/27.
//

import UIKit

final class CompositionalLayoutViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.register(Cell.nib, forCellWithReuseIdentifier: Cell.identifier)
            collectionView.register(Badge.self, forSupplementaryViewOfKind: Badge.elementKind, withReuseIdentifier: Badge.identifier)
            collectionView.collectionViewLayout = Layout.shared.createLayoutWithBadge()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CompositionalLayoutViewController: UICollectionViewDataSource {
    
    //表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //セル
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        cell.setUp(text: "\(indexPath.item)")
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Badge.identifier, for: indexPath)
        return badgeView
    }
    
}
