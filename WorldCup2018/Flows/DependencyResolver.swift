//
//  DependencyResolver.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

class DependencyResolver {
  
  static let sharedResolver = DependencyResolver()
  
  func groupsViewModel() -> GroupsViewModel {
    return GroupsViewModel(repository: groupsRepository())
  }
  
  func teamDetailViewModelWithTeam(team: Team) -> TeamDetailViewModel {
    return TeamDetailViewModel(team: team)
  }
  
  func groupsRepository() -> GroupsRepository {
    return GroupsRepository(loader: localJSONLoader())
  }
  
  func localJSONLoader() -> LocalJSONLoader {
    return LocalJSONLoader()
  }
}
