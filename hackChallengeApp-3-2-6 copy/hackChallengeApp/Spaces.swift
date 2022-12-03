//
//  Spaces.swift
//  HackathonApp
//
//  Created by Wei Zheng on 11/24/22.
//

import Foundation
import UIKit


class Spaces{
    var name: String
    var pic : String
    var availableSpace: String

    init(name: String, pic: String, availableSpace: String) {
        self.name = name
        self.pic = pic
        self.availableSpace = availableSpace
    }
}
