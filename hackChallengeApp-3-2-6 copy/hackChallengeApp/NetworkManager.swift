//
//  NetworkManager.swift
//  hackChallengeApp
//
//  Created by Wei Zheng on 11/30/22.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static let endpoint = "http://35.245.236.156/api/bookings/"
    
    static func getAllBookings(completion: @escaping([Spacess]) -> Void){
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let spaceResponse = try? jsonDecoder.decode(SpaceResponse.self, from: data){
                    let spaces = spaceResponse.bookings
                    completion(spaces)
                }
                else{
                    print("failed to decode getAllBookings")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getBookingsById(id: Int,completion: @escaping(String) -> Void){
        AF.request("\(endpoint)/\(id)/", method: .get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let spaceResponse = try? jsonDecoder.decode(SpacResponse.self, from: data){
                    let spaces = spaceResponse.timeslot
                    completion(spaces)
                }
                else{
                    print("failed to decode getBookingsID")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createUser(email: String, password: String,completion: @escaping(String) -> Void){
        
        let parameters = [
            
            "email": email,
            "password": password
        ]
        
        AF.request("http://35.245.236.156/api/users/create/",method: .post,parameters: parameters,encoding: JSONEncoding.default).validate().responseData { reponse in
            switch reponse.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(userResponse.self, from: data){
                    let sessionToken = userResponse.session_token
                    completion(sessionToken)
                }
                else{
                    print("failed to decode")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getBookingsofaUser(token: String, completion: @escaping([bookings]) -> Void){
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        AF.request("http://35.245.236.156/api/users/bookings/",method: .get,headers: headers).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let BookingInfo = try? jsonDecoder.decode(BookingResponse.self, from: data){
                    let bookings = BookingInfo.bookings
                    completion(bookings)
                }
                else{
                    print("Failed to decode")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    

    
    static func AddaUserToaBookingById(id: Int, token: String, completion: @escaping(UserAddindBookingReesponse) -> Void){
        let idd = [
            "id": id
        ]
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        
        ]
        
        
        print("\(endpoint)\(idd)/add/")
        AF.request("\(endpoint)\(id)/add/",method: .post, headers: headers ).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userinfo = try? jsonDecoder.decode(UserAddindBookingReesponse.self, from: data){
                    let userinfo = userinfo
                    completion(userinfo)
                }
                else{
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    static func loginUser(email: String, password: String, compeletion: @escaping(String) -> Void){
        let parameters = [
            "email": email,
            "password": password
        ]
        AF.request("http://35.245.236.156/login",method: .post,parameters: parameters,encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(userResponse.self, from: data){
                    let sessionToken = userResponse.session_token
                    compeletion(sessionToken)
                }
                else{
                    print("failed to decode")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

