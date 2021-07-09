//
//  TeamDetailViewController.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation
import UIKit

class TeamDetailViewController: UIViewController {
  private var viewModel: TeamDetailViewModel
  private var textLabel: UILabel!
  private var imageView: UIImageView!
  init (viewModel: TeamDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    viewModel.onUpdateSignal = { [weak self] viewData in
      DispatchQueue.main.async {
        self?.imageView.image = viewData.image
        self?.textLabel.text = viewData.name
      }
    }
    
    viewModel.load()
  }
  
  private func setupView() {
    title = "Groups"
    self.view.backgroundColor = .white
    
    textLabel = UILabel()
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(textLabel)
    
    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(imageView)
    
    
    let constraints = [
      imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
      imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
      imageView.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -20),
      imageView.heightAnchor.constraint(equalToConstant: 30),
      imageView.widthAnchor.constraint(equalToConstant: 50),
      textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
    ]
    constraints.activate()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
