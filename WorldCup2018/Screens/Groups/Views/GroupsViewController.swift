//
//  GroupsViewController.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation
import UIKit

class GroupsViewController: UIViewController {
  
  private var tableView: UITableView!
  private var searchBar: UISearchBar!
  private var viewModel: GroupsViewModel
  private var groups: [Group]?
  private var sectionsViewData: [SectionViewData]?
  init (viewModel: GroupsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle:nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    viewModel.onUpdateSignal = { [weak self] groups in
      self?.populateDataSource(items: groups)
    }
    
    viewModel.load()
  }
  
  func setupView() {
    title = "World Cup 2018"
    
    searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.delegate = self
    
    view.addSubview(searchBar)
    
    tableView = UITableView(frame: CGRect.zero, style: .grouped)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.keyboardDismissMode = .onDrag
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(tableView)
    
    let constraints = [
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
      searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      searchBar.heightAnchor.constraint(equalToConstant: 80)
    ]
    
    constraints.activate()
  }
  
  func populateDataSource(items: [SectionViewData]) {
    sectionsViewData = items
    tableView.reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell:UITableViewCell!
    
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    cell.textLabel?.text = sectionsViewData?[indexPath.section].teams[indexPath.row].name ?? ""
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionsViewData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionsViewData?[section].teams.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionsViewData?[section].name ?? ""
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.selectTeam(index: indexPath)
  }
}

extension GroupsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.search(query: searchText)
  }
}
