// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation


// MARK: - User
class User: Codable{
    
    let serverRequest: Int?
    let name, lastName: String?
    let email, password: String?
    let apiToken: String?
    let avatarID: Int?
    
    enum CodingKeys: String, CodingKey {
        case serverRequest,name, lastName, email, password
        case apiToken = "api_token"
        case avatarID = "avatar_id"
    }
    
    init(name: String?, lastName: String?,email: String?, password: String?, avatarID: Int?) {
        self.serverRequest = nil
        self.apiToken = nil
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
        self.avatarID = avatarID
    }
    
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
        self.avatarID = nil
        self.serverRequest = nil
        self.apiToken = nil
        self.name = nil
        self.lastName = nil
    }
}
