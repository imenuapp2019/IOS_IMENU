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
    let registerPostUrl = URL(string:"http://localhost:8888/back_imenu/public/api/register")
    let LoginPostUrl = URL(string:"http://localhost:8888/back_imenu/public/api/login")
    
    
    func postLogin(user:User){
        // parameters that are needed to be posted in the backend
        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        print("Entro en este post")
        
        AF.request(LoginPostUrl ?? "Login Vacio", method:.post, parameters:parameters as Parameters ,encoding: JSONEncoding.default).responseJSON { response in
            switch (response.result) {
            case .success:
                do{
                    
                }catch{
                    
                }
            case .failure(let error):
                print(error)
                
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
}
