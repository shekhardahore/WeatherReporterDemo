//
//  WeatherHomeViewController+Extension.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 18/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

extension WeatherHomeViewController {
    
    enum Section: CaseIterable {
        case summary
        case details
        
        static func sectionFor(index: Int) -> Section {
            switch index {
            case 0:
                return .summary
            case 1:
                return .details
            default:
                fatalError("Invalid section called")
            }
        }
    }
    /// Updates the UI with the weather data
    func showWeather() {
        homeCollectionView.isHidden = false
        view.addSubviews(homeCollectionView)
        NSLayoutConstraint.activate([
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupCollectionView()
        configureDataSource()
    }
    
    private func setupCollectionView() {
        homeCollectionView.collectionViewLayout = generateLayout()
        
        homeCollectionView.registerReusableCell(WeatherSummaryTableViewCell.self)
        homeCollectionView.registerReusableCell(WeatherDetailTableViewCell.self)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch Section.sectionFor(index: sectionIndex) {
            case .summary:
                return self.generateSummarySectionLayout()
            case .details:
                return self.generateDetailSectionLayout()
            }
        }
        return layout
    }
    
    private func generateSummarySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //  summaryItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func generateDetailSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
            <Section, DataItem>(collectionView: homeCollectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, detailItem: DataItem) -> UICollectionViewCell? in
                switch detailItem {
                case .summary(let data):
                    let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as WeatherSummaryTableViewCell
                    cell.cellModel = WeatherSummaryCellViewModel(data: data)
                    return cell
                case .details(let data):
                    let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as WeatherDetailTableViewCell
                    cell.cellModel = WeatherDetailCellViewModel(data: data)
                    return cell
                }
        }
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, DataItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataItem>()
        snapshot.appendSections([.summary, .details])
        snapshot.appendItems([DataItem.summary(data: viewModel.getWeatherSummaryModel())], toSection: .summary)
        snapshot.appendItems(viewModel.getWeatherDetailModels(), toSection: .details)
        return snapshot
    }
}
