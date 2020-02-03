//
//  ImageDownloader.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 31/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ImageDownloader {
    
    func downloader(URLString UrlString:String,completion: @escaping (UIImage?) -> Void){
        guard let urlRequest = URL(string: UrlString) else {return}
        var image:UIImage?
        Alamofire.request(urlRequest).responseImage { response in
            image = UIImage(data: response.data!)
            completion(image)
        }
    }
}
