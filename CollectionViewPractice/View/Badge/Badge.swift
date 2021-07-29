//
//  Badge.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/29.
//

import Foundation
import UIKit

final class Badge: UICollectionViewCell {
    static let identifier = "Badge"
    static let elementKind = "badge-element-kind"
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(Int.random(in: 0...5))
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundColor = .red
        isHidden = Bool.random()
        //円にする
        layer.cornerRadius = bounds.width/2
    }
}
