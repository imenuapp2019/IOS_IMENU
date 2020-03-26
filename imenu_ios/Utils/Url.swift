//
//  URL.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 06/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

open class Url{
    static var registerPostUrl = URL(string:"http://localhost:8888/back_imenu/public/api/register")
    static var LoginPostUrl = URL(string: "http://localhost:8888/back_imenu/public/api/loginApi")
    static var RecoverPostUrl = URL(string: "http://localhost:8888/back_imenu/public/api/password/email")
    static var restaurantURL = URL(string: "http://localhost:8888/back_imenu/public/api/res")
}
