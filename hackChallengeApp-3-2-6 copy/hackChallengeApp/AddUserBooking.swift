//
//  AddUserBooking.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 12/2/22.
//

import Foundation


struct UserAddindBookingReesponse: Codable{
    var id: Int
    var name: String
    var location: String
    var capacity: String
    var timeslot: String
    var status: Bool
    var users: [usersinfo]
}

struct usersinfo: Codable{
    var id: Int
    var email: String
}
