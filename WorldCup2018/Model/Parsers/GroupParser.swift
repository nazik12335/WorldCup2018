//
//  GroupParser.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

struct GroupParser {
  func parse(json: [String: Any], key: String) -> Group {
    
    // Required fields
    var groupName: String?
    var groupTeams: [Team] = []
    
    if let name = json["name"] as? String {
      groupName = name
    }else {
      fatalError("GroupParser.name.nonexistent")
    }
    
    if let teams = json["teams"] as? [JSON?] {
      var tempTeams: [Team] = []
      for team in teams {
        if let _ = team {
          let parsedTeam = TeamParser().parse(json: team!)
          tempTeams.append(parsedTeam)
        }else {
          fatalError("GroupParser.team.nonexistent")
        }
      }
      groupTeams = tempTeams.sorted(by: {$0.name < $1.name})
    }else {
      fatalError("GroupParser.teams.nonexistent")
    }
    
    return Group(key: key, name: groupName!, teams: groupTeams)
  }
}
