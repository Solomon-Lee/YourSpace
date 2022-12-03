//
//  Space.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/30/22.
//

import Foundation




struct SpacResponse: Codable{
    var id: Int
    var name: String
    var location: String
    var capacity: String
    var timeslot: String
    var category: Int
    var users: [Userinfo]
}


struct SpaceResponse: Codable{
    var bookings: [Spacess]
}

struct Spacess: Codable{
    var id: Int
    var name: String
    var location: String
    var capacity: String
    var timeslot: String
    var category: Int
    var users: [Userinfo]
}

struct Userinfo: Codable{
    var id: Int
    var email: String
}
