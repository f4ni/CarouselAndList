//
//  MainViewController.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = ViewModel()
    private var collectionView: UICollectionView!
    private var floatingButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
        viewModel.fetchMovies()
    }
    
    private func setupBinding() {
        viewModel.$movieList
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$selection
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.updateList()            }
            .store(in: &cancellables)
        
        viewModel.$searchText
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.updateList()
            }
            .store(in: &cancellables)
        
    }
    
    private func updateList() {
        self.collectionView.performBatchUpdates({
            let indexPathsToDelete = (0..<collectionView.numberOfItems(inSection: 1)).map { IndexPath(item: $0, section: 1) }
            collectionView.deleteItems(at: indexPathsToDelete)
            let range = 0..<(viewModel.filteredMovies.count)
            let indexPaths = range.map { IndexPath(item: $0, section: 1) }
            collectionView.insertItems(at: indexPaths)
        })

    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .bg
        title = "Movie Bag"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupCollectionView()
        
        setupFloatingButton()
       
        setupActivityIndicator()
    }
    
    private func setupCollectionView() {
        // Collection View
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupFloatingButton() {
        // Floating Button
        let action = UIAction {[weak self] _ in
            self?.floatingButtonTapped()
        }
        floatingButton = UIButton(type: .system)
        floatingButton.setImage(UIImage(systemName: "ellipsis")?
            .withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.tintColor = .white
        floatingButton.backgroundColor = .floatingButton
        floatingButton.layer.cornerRadius = 24
        floatingButton.addAction(action, for: .primaryActionTriggered)
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButton.widthAnchor.constraint(equalToConstant: 48),
            floatingButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    private func setupActivityIndicator() {
        // Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.createBannerSection()
            } else {
                return self.createMovieListSection()
            }
        }
        
        return layout
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(260))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, environment) in
            let index = visibleItems.last?.indexPath.row ?? 0
            self?.viewModel.bannerItem(index)
            
        }
        return section
    }
    
    private func createMovieListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    // MARK: - Actions
    private func floatingButtonTapped() {
        let sheetViewController = SheetViewController()
        sheetViewController.viewModel = viewModel
        present(sheetViewController, animated: true)
    }
}



extension MainViewController: SearchHeaderViewDelegate {
    func searchHeaderView(didChangeSearchText text: String) {
        viewModel.searchText = text
    }
}


#Preview {
    UINavigationController(rootViewController: MainViewController())
}
