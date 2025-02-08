//
//  SheetViewController.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

// MARK: - Sheet View Controller
class SheetViewController: UIViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        [
            UILabel(text: viewModel.listOfMoviesNames()),
            UILabel(text: viewModel.countOfMovies()),
            UILabel(text: viewModel.getTopOccurringForList())
        ]
            .map { $0.encapsulate(backgroundColor: .listbackground) }
            .forEach(stackView.addArrangedSubview)
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        sheetPresentationController?.detents = [.medium()]
    }
}
