//
//  LocalJSONLoader.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

protocol JSONLoader {
  func loadJSON(completion: ((JSON) throws ->())) throws
}

class LocalJSONLoader: JSONLoader {
  private let fileLoader = FileLoader()
  
  func loadJSON(completion: ((JSON) throws -> ())) throws {
    
    guard let data = try fileLoader.loadJSON(named: "WorldCup2018") else {
      throw(NSError(domain: "NSData.error", code: 01, userInfo: nil))
    }
    
    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON else {
      throw(NSError(domain: "JSONSerialization.error", code: 01, userInfo: nil))
    }
    
    try completion(json)
    
  }
}
