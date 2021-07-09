//
//  FileLoader.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation

class FileLoader {
  
  func loadJSON(named name: String) throws -> Data? {
    
    let resourceUrl = Bundle.main.url(forResource: name, withExtension: "json")
    
    guard let url = resourceUrl else {return nil}
    
    let data = try Data(contentsOf: url)
    return data
  }
  
}
