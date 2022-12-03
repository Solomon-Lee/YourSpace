//
//  BookingInfo.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 12/2/22.
//

import Foundation

struct BookingResponse: Codable{
    var bookings: [bookings]
}


struct bookings: Codable{
    var id: Int
    var name: String
    var location: String
    var capacity: Int
    var timeslot: String
    var category: Int
    var status: Bool
}

struct userinfoo: Codable{
    var id: Int
    var email: String
}
