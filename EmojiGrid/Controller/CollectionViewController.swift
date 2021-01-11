//
//  ViewController.swift
//  SFGrid
//
//  Created by Makwan BK on 2021-01-11.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    static let headerKind = "header-view-kind"
    
    enum Section: String, CaseIterable {
        case laugh = "Laugh Emojies"
        case cry = "Cry Emojies"
        case love = "Love Emojies"
    }
    
    var dataSource : UICollectionViewDiffableDataSource<Section, ReactionItem>! = nil
    
    let loveEmojiTexts : [String] = [
        "Heart",
        "Face Blowing a Kiss",
        "Smiling Face with Heart-Eyes",
        "Smiling Face with Hearts",
        "Smiling Cat with Heart-Eyes",
        "Hearts",
        "Revolving Hearts",
        "Heart Exclamation"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "EmojiGrid"
        
        configureCollectionView()
        configureDataSource()
        
    }

    func configureCollectionView() {
        
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.reusableIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: CollectionViewController.headerKind, withReuseIdentifier: HeaderView.reuseIdentifieble)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = generateLayout()
        
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [unowned self] (sectionIndex: Int,
                                                              layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionType = Section.allCases[sectionIndex]
            
            switch sectionType {
            case .laugh:
                return configureLaughLayout()
            case .cry:
                return configureSadLayout()
            case .love:
                return configureLoveLayout(layoutEnvironment)
            }
            
        }
        
        return layout
    }
    
    func configureLaughLayout() -> NSCollectionLayoutSection {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: CollectionViewController.headerKind, alignment: .top)
                
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(2/9))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .continuous
        
        return section

    }
    
    func configureSadLayout() -> NSCollectionLayoutSection {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: CollectionViewController.headerKind, alignment: .top)
        
                
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]

        return section
        
    }
    
    func configureLoveLayout(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(44.0)), elementKind: CollectionViewController.headerKind, alignment: .top)
        
        let section = NSCollectionLayoutSection.list(using: .init(appearance: .insetGrouped), layoutEnvironment: layoutEnvironment)
        section.boundarySupplementaryItems = [headerItem]
        
        
        return section
    }
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, ReactionItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, sfItem) -> UICollectionViewCell? in
            
            let sectionType = Section.allCases[indexPath.section]
            
            switch sectionType {
            case .laugh, .cry:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reusableIdentifier, for: indexPath) as? EmojiCell else {fatalError()}
                
                cell.label.text = sfItem.icon
                            
                return cell
                
            case .love:
                
                let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, ReactionItem> { (cell, indexPath, item) in
                    
                    var content = cell.defaultContentConfiguration()
                    content.text = self.loveEmojiTexts[indexPath.row]
                    content.textProperties.font = .preferredFont(forTextStyle: .headline)
                    content.image = item.icon.image()
                    
                    cell.tintColor = .systemRed
                    cell.contentConfiguration = content
                    
                    
                }
                     
                return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: sfItem)
                
            }
                        
        })
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  kind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifieble, for: indexPath) as? HeaderView else {fatalError(">>> There's something wrong with the header view!")}
            
            headerView.label.text = Section.allCases[indexPath.section].rawValue
            
            return headerView
            
        }
        
        let snapshot = configureSnapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    func configureSnapshot() -> NSDiffableDataSourceSnapshot<Section, ReactionItem> {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ReactionItem>()
        snapshot.appendSections([.laugh])
        snapshot.appendItems(ReactionItem.laugh)
        
        snapshot.appendSections([.cry])
        snapshot.appendItems(ReactionItem.cry)
        
        snapshot.appendSections([.love])
        snapshot.appendItems(ReactionItem.love)
        
        return snapshot
        
    }
    

}

