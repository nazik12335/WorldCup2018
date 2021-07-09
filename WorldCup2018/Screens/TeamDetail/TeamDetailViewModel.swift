//
//  TeamDetailViewModel.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import Foundation
import UIKit

struct TeamDetailViewData {
  var name: String
  var image: UIImage?
}

// ViewModel
class TeamDetailViewModel {
  private var team: Team
  var onUpdateSignal: ((TeamDetailViewData)->())?
  var viewData: TeamDetailViewData? {
    didSet {
      if let vd = viewData {
        onUpdateSignal?(vd)
      }
    }
  }
  init(team: Team) {
    self.team = team
  }
  
  func load() {
    ImageLoader().loadImageFor(path: self.team.imagePath) { [weak self] (image) in
      self?.viewData = TeamDetailViewData(name: "Name: \(self?.team.name ?? "")", image: image)
    }
  }
  
}
