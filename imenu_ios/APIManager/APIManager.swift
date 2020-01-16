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
    
    func postLogin(Email email:String, Password password:String){
        
        // parameters that are needed to be posted in the backend
        let params = [
            "email": email,
            "password": password
        ] as [String : Any]
        
        Alamofire.request("", method: .post, parameters: params, headers: headers).responseString  { response in
            print(response.request) // original url request
            print(response.response) // http url reponse
            if let json = response.result.value {
               print("JSON: \(json)") // serialized json response after post
            }       
        }
    }
}
