//
//  APIManager.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 16/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import Alamofire

class APIManager {
    
    func postLogin(user:User,completion: @escaping (Int?) -> Void){
        
        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        Alamofire.request(Url.LoginPostUrl ?? "Login Vacio", method:.post, parameters:parameters as Parameters ,encoding: JSONEncoding.default).responseJSON { response in
            switch (response.result) {
            case .success:
                    let decoder = JSONDecoder()
                    let user = try! decoder.decode(User.self, from: response.data!)
                    completion(user.serverRequest)
            case .failure(_):
                let code = 600
                completion(code)
            }
        }
    }
    
    public func postRegister (user: User,completion: @escaping (Bool?) -> Void){
        
        let parameters:[String : Any] = [
            "name":user.name!,
            "lastName":user.lastName!,
            "email" :user.email!,
            "password":user.password!,
            "avatar_id":user.avatarID!
        ]
        
        Alamofire.request(Url.registerPostUrl ?? "Registro Vacio" , method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                    break
                case .failure(_):
                    completion(false)
                    break
                }
        }
    }
    
    public func getAllRestaurants(completion: @escaping ([Restaurant]) -> Void){
        
        Alamofire.request(Url.restaurantURL ?? "",method: .get).responseJSON {
            (response) in
            switch (response.result){
            case .success:
                    let decoder = JSONDecoder()
                    guard let restaurants = try? decoder.decode(Restaurant.self, from: response.data!) else {return}
                    completion([restaurants])
            case .failure(_):
                break
            }
        }
    }
    
    public func postRecover (email: String,completion: @escaping (Int?) -> Void){
        
        let parameters:[String : Any] = [
            "email" :email,
        ]
        
        Alamofire.request(Url.RecoverPostUrl ?? "Recover Vacio" , method: .post, parameters: parameters, encoding: JSONEncoding.default).validate()
            .responseJSON() { response in
                switch response.result {
                case .success:
                    let resultParse = String.init(data: response.data!, encoding: String.Encoding.utf8)
                    let codeServer = Int.init(resultParse ?? "")
                    completion(codeServer)
                    break
                case .failure(_):
                    completion(600)
                    break
                }
        }
    }
    
    
    public func deleteAccount () {
        
        
        
    }
}
