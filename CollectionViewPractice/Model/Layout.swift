//
//  Layout.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/27.
//

import Foundation
import UIKit

final class Layout {
    
    static let shared = Layout()
    private init(){}
    
    //横長のcell
    func createLayout1() -> UICollectionViewCompositionalLayout {
        //itemの横幅はGroupサイズ比1, 縦の長さはGroupサイズ比1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Groupの横幅はSectionサイズ比1,縦の長さはSectionサイズ比0.1
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        //itemを水平に並べる
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    //Grid5
    func createLayout2() -> UICollectionViewCompositionalLayout {
        //横幅はgroupの1/5
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //高さは横幅の1/5 == itemの横幅と同じ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    //three-column grid
    func createLayout3() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        //countを3にすることで1groupの中に3個itemを配置する
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    //セクションごとに違うセルを返す
    func createLayout4() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { section, environment -> NSCollectionLayoutSection? in
            
            guard let count = SectionLayoutKind(rawValue: section) else { return nil }
//            let column = count.columnCount
            //回転させた時にレイアウトが変わるようにする
            let column = count.columnCount(width: environment.container.effectiveContentSize.width)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
            //countをsectionごとに区別することでセクションごとに違うgroupを作る
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: column)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
    //grid5+badge
    func createLayoutWithBadge() -> UICollectionViewCompositionalLayout{
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.5, y: -0.5))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20),
                                               heightDimension: .absolute(20))
        let badge = NSCollectionLayoutSupplementaryItem(
            layoutSize: badgeSize,
            elementKind: Badge.elementKind,
            containerAnchor: badgeAnchor)
        //横幅はgroupの1/4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //高さは横幅の1/5 == itemの横幅と同じ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

enum SectionLayoutKind: Int {
    case list, grid5, grid3
    var columnCount: Int{
        switch self{
        case .list: return 1
        case .grid5: return 5
        case .grid3: return 3
        }
    }
    func columnCount(width: CGFloat)->Int{
        //画面を回転させた時の横幅に合わせてcountを変更しレイアウトを変える
        let viewMode = width>450 //Bool
        print(viewMode)
        switch self{
        //三項演算子　true : false
        case .list: return viewMode ? 2:1
        case .grid3: return viewMode ? 6:3
        case .grid5: return viewMode ? 10:5
        }
    }
}
