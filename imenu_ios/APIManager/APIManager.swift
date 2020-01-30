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
    let registerPostUrl = URL(string:"http://localhost:8888/back_imenu-develop/public/api/register")
    let LoginPostUrl = URL(string: "http://localhost:888/")
    let RecoverPostUrl = URL(string: "http://localhost:8888/back_imenu/public/api/password/email")
    
    func postLogin(user:User,completion: @escaping (Int?) -> Void){

        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        AF.request(LoginPostUrl ?? "Login Vacio", method:.post, parameters:parameters as Parameters ,encoding: JSONEncoding.default).responseJSON { response in
            switch (response.result) {
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let user = try! decoder.decode(User.self, from: response.data!)
                    completion(user.serverRequest)
                }catch{
                    print(error.localizedDescription)
                }
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
        
        AF.request(registerPostUrl ?? "Registro Vacio" , method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
        let restaurantURL = URL(string: "http://localhost:8888/back_imenu/public/api/homeRestaurante")
       
        AF.request(restaurantURL!,method: .get).responseJSON {
            (response) in
            switch (response.result){
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let restaurants = try! decoder.decode(Restaurant.self, from: response.data!)
                    completion([restaurants])
                }catch{
                    print("Error en la conexion")
                }
            case .failure(_):
                print("ERROR!!")
                break
            }
        }
    }
    
    public func postRecover (email: String,completion: @escaping (Bool?) -> Void){
        
        
        let parameters:[String : Any] = [
            "email" :email,
        ]
        
        print(email)
        AF.request(RecoverPostUrl ?? "Recover Vacio" , method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
}
