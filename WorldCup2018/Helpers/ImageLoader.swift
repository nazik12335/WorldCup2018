//
//  ImageLoader.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation
import UIKit

class ImageLoader {
  func loadImageFor(path: String, completion: @escaping ((UIImage?)->())) {
    DispatchQueue.global(qos: .default).async {
      
      guard let url = URL(string: path) else {
        return completion(nil)
      }
      
      guard let data = try? Data(contentsOf: url) else {
        return completion(nil)

      }
      
      guard let image = UIImage(data: data) else {
        return completion(nil)
      }

      completion(image)
      
    }
  }
}
