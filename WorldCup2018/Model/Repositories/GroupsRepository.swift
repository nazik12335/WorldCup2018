//
//  GroupsRepository.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

protocol GroupsRepositoryType {
  func loadGroups(completion: (([Group]) -> ())) throws
  func search(groups: [Group], query: String, completion:(([Team])->()))
}

class GroupsRepository: GroupsRepositoryType {
  private var jsonLoader: JSONLoader
  
  init (loader: JSONLoader) {
    jsonLoader = loader
  }
  
  func loadGroups(completion: (([Group]) -> ())) throws {
    try jsonLoader.loadJSON { (json) in
      
      guard let groups = (json["groups"] as? JSON) else {
        throw(NSError(domain: "GroupsRepository", code: 03, userInfo: nil))
      }
     
      var parsedGroups: [Group] = []
      for (key, optionalValue) in groups {
       
        guard let value = optionalValue as? JSON else {
          throw(NSError(domain: "GroupsRepository", code: 03, userInfo: nil))
        }
        
        let parsedGroup = GroupParser().parse(json: value, key: key)
        parsedGroups.append(parsedGroup)
      }
      
      completion(parsedGroups.sorted(by: {$0.key < $1.key}))
    }
  }
  
  func search(groups: [Group], query: String, completion:(([Team])->())) {
    var teams: [Team] = []
    for group in groups {
      teams.append(contentsOf: group.teams)
    }
    
    if query.count > 0 {
      let filtered = teams.filter { $0.name.hasPrefix(query) }
      completion(filtered)
    }else {
      completion([])
    }
    
  }
  
}
