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
    
    func postLogin(Email email:String, Password password:String){
        
        
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
