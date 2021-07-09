//
//  TeamParser.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

struct TeamParser {
  func parse(json: JSON) -> Team {
    
    // Required fields
    var teamName: String?
    var imagePath: String?
    
    if let name = json["name"] as? String {
      teamName = name
    }else {
      fatalError("TeamParser.name.nonexistent")
    }
    
    if let path = json["flag"] as? String {
      imagePath = path
    }else {
      fatalError("TeamParser.flag.nonexistent")
    }
    
    return Team(name: teamName!, imagePath: imagePath!)
  }
}
