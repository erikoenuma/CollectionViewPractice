//
//  BadgeViewController.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/29.
//

import UIKit

final class BadgeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(Cell.nib, forCellWithReuseIdentifier: Cell.identifier)
            collectionView.register(Badge.self, forSupplementaryViewOfKind: Badge.elementKind, withReuseIdentifier: Badge.identifier)
            collectionView.collectionViewLayout = Layout.shared.createLayoutWithBadge()
        }
    }
    
    enum Section{
        case main
    }
    
    struct BadgeModel: Hashable {
        let title: String
        let badgeCount: Int

        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureDataSource(){
        //セルを登録
        let dataSource = UICollectionViewDiffableDataSource<Section, BadgeModel>(collectionView: collectionView) { collectionView, indexPath, model ->UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
            cell.setUp(text: "\(indexPath.item)")
            return cell
        }
        //Badgeを登録
        dataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
        }
        var snapShot = NSDiffableDataSourceSnapshot<Section, BadgeModel>()
        snapShot.appendSections([.main])
        
        dataSource.apply(snapShot)
    }
    
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
        case Badge.identifier:
            let badge = collectionView.dequeueReusableSupplementaryView(ofKind: Badge.elementKind, withReuseIdentifier: Badge.identifier, for: indexPath) as! Badge
            return badge

        default:
            assertionFailure("Handle new kind")
            return nil
        }
    }
}
