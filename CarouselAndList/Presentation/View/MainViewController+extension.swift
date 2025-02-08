//
//  MainViewController+extension.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

// MARK: - UICollectionViewDataSource & Delegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // Banner + Movie List
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.movieList?.bannerList?.count ?? 0
        } else {
            return viewModel.filteredMovies.filter { $0.type == viewModel.selection?.type }.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as! BannerCell
            if let banner = viewModel.movieList?.bannerList?[indexPath.item] {
                cell.configure(with: banner)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            let movie = viewModel.filteredMovies.filter { $0.type == viewModel.selection?.type }[indexPath.item]
            cell.configure(with: movie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1,
           let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SearchHeaderView.reuseIdentifier,
            for: indexPath
           ) as? SearchHeaderView {
            header.delegate = self
            header.configure(with: viewModel)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print(elementKind)
        print(indexPath)
    }
}
