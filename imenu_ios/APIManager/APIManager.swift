//
//  APIManager.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 16/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    let registerPostUrl = URL(string:"http://localhost:8888/back_imenu-develop/public/api/register")
    
    func postLogin(user:User){
        // parameters that are needed to be posted in the backend
       let parameters = [
        "email": user.email,
        "password": user.password
        ]
        
        let url = "http://localhost:8888/back_imenu/public/api/login"
        AF.request(url, method:.post, parameters:parameters as Parameters ,encoding: JSONEncoding.default).responseJSON { response in
                    switch response.result {
                    case .success:
                       print(response)
                    case .failure(let error):
                        print(error )
                    }
                }
    }
    
    
    public func postAlamofire (user: User)  {
        let int:Int = 1
        let parameters:[String : Any] = [
            "name":user.name!,
            "lastName":user.lastName!,
            "email" :user.email!,
            "password":user.password!,
            "avatar_id":int
        ]
    
       
       AF.request(registerPostUrl!, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            print(response)
        }
    }
}
