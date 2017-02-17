//
//  ExtensionCollection.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation
extension String {
  func extractURLs() -> [NSURL] {
    var urls : [NSURL] = []
    do {
      let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
      detector.enumerateMatches(in: self,
                                options: [],
                                range: NSMakeRange(0, self.characters.count),
                                using: { (result, _, _) in
                                          if let match = result, let url = match.url {
                                            urls.append(url as NSURL)
                                          }
      })
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    return urls
  }
}
