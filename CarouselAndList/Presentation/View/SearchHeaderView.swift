//
//  SearchHeaderView.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit


protocol SearchHeaderViewDelegate: AnyObject {
    func searchHeaderView(didChangeSearchText text: String)
}

// MARK: - Search Header View
class SearchHeaderView: UICollectionReusableView {
    weak var delegate: SearchHeaderViewDelegate?
    static let reuseIdentifier = "SearchHeaderView"
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ViewModel) {
        searchBar.text = viewModel.searchText
        searchBar.delegate = self
    }
    
    private func setupBackground() {
        let effect = UIBlurEffect(style: .prominent)
        let blurView = UIVisualEffectView(effect: effect)
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SearchHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchHeaderView(didChangeSearchText: searchText)
    }
}
