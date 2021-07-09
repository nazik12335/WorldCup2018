//
//  GroupsViewModel.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

struct TeamCellViewData {
  var name: String
}

struct SectionViewData {
  var name: String
  var teams: [TeamCellViewData]
}

/// Groups

// ViewModel
class GroupsViewModel {
  
  var onSelectItemSignal: ((Team)->())?
  var onUpdateSignal: (([SectionViewData])->())?
  var onErrorSignal: ((String)->())?
  private var isSearching = false
  private var repository: GroupsRepositoryType
  private var groups: [Group] = []
  private var searchingTeams: [Team] = []
  private var sectionsViewData: [SectionViewData] = [] {
    didSet {
      onUpdateSignal?(sectionsViewData)
    }
  }
  init (repository: GroupsRepositoryType) {
    self.repository = repository
  }
  
  func load() {
    do{
      try repository.loadGroups {[weak self] (result) in
        self?.handleResult(result: result)
      }
    }catch let error as NSError {
      onErrorSignal?(error.localizedDescription)
    }
  }
  
  private func handleResult(result: [Group]) {
    sectionsViewData.removeAll()
    groups.removeAll()
    groups.append(contentsOf: result)
    var internalSectionsViewData: [SectionViewData] = []
    for group in result {
      var teamsCellViewData: [TeamCellViewData] = []
      for team in group.teams {
        let teamCellViewData = TeamCellViewData(name: team.name)
        teamsCellViewData.append(teamCellViewData)
      }
      let sectionViewData = SectionViewData(name: group.name, teams: teamsCellViewData)
      internalSectionsViewData.append(sectionViewData)
    }
    
    sectionsViewData = internalSectionsViewData
  }
  
  func selectTeam(index: IndexPath) {
    let team: Team!
    
    if isSearching {
      team = searchingTeams[index.row]
    }else {
      team = groups[index.section].teams[index.row]
    }
    onSelectItemSignal?(team)
  }
  
  func search(query: String) {
    repository.search(groups: groups, query: query) { (teams) in
      searchingTeams = teams
      if (teams.count == 0 && query.count == 0) {
        isSearching = false
        return handleResult(result: groups)
      }
      isSearching = true
      var teamsCellViewData: [TeamCellViewData] = []
      
      for team in teams {
        let teamCellViewData = TeamCellViewData(name: team.name)
        teamsCellViewData.append(teamCellViewData)
      }
      let sectionViewData = SectionViewData(name: "Search", teams: teamsCellViewData)
      sectionsViewData = [sectionViewData]
    }
  }
}
