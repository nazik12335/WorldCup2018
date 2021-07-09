//
//  ViewController.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import UIKit
// Application Flow

class AppFlowCoordinator {
  
  private let resolver = DependencyResolver.sharedResolver
  private var navigationController: UINavigationController?
  
  func start(window: UIWindow?) {
    window?.makeKeyAndVisible()
    
    let groupsViewModel = resolver.groupsViewModel()
    let groupsVC = GroupsViewController(viewModel: groupsViewModel)
    groupsViewModel.onSelectItemSignal = { [weak self] team in
      self?.showTeamDetail(team: team)
    }
    
    groupsViewModel.onErrorSignal = { [weak self] errorMessage in
      self?.showAlert(message: errorMessage)
    }
    
    navigationController = UINavigationController(rootViewController: groupsVC)
    navigationController?.navigationBar.barTintColor = .systemBlue
    navigationController?.navigationBar.tintColor = .white
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    window?.rootViewController = navigationController
  }
  
  private func showTeamDetail(team: Team) {
    let teamViewModel = resolver.teamDetailViewModelWithTeam(team: team)
    let teamDetailViewController = TeamDetailViewController(viewModel: teamViewModel)
    navigationController?.pushViewController(teamDetailViewController, animated: true)
  }
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK!", style: .default, handler: nil)
    alert.addAction(alertAction)
    navigationController?.present(alert, animated: true, completion: nil)
  }
  
}




