//
//  Cell.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/27.
//

import Foundation
import UIKit

final class Cell: UICollectionViewCell {
    
    @IBOutlet private weak var label: UILabel!
    static let nib = UINib(nibName: "Cell", bundle: nil)
    static let identifier = "Cell"
    
    func setUp(text: String){
        label.text = text
        backgroundColor = UIColor.systemBlue
        layer.cornerRadius = 15
    }
}
