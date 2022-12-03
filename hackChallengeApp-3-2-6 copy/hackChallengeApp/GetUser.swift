//
//  GetUser.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 12/2/22.
//

import Foundation


struct getBookingbyIdResponse: Codable{
    var bookings: [bookingDetails]
}

struct bookingDetails: Codable{
    var id: Int
    var name: String
    var location: String
    var capacity: String
    var timeslot: String
    var category: Int
    var status: Bool
}
