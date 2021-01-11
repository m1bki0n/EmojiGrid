//
//  CommunicationCell.swift
//  SFGrid
//
//  Created by Makwan BK on 2021-01-11.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    static let reusableIdentifier = "SFCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}
