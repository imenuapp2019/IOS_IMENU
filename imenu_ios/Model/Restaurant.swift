import Foundation

// MARK: - RestaurantElement
class RestaurantElement: Codable {
      let name, type: String?
      let imageURL: String?
      let latitude, longitude: Double?
      var coordinates: [Double]=[]
    
      enum CodingKeys: String, CodingKey {
          case name, type
          case imageURL = "image_URL"
          case latitude, longitude
      }

      init(name: String?, type: String?, imageURL: String?, latitude: Double?, longitude: Double?) {
          self.name = name
          self.type = type
          self.imageURL = imageURL
          self.latitude = latitude
          self.longitude = longitude
      }
    init(name:String,type:String,urlImage:String,latitude:Double,longitude:Double){
        
            self.latitude = nil
            self.longitude = nil
            self.name = name
            self.type = type
            self.imageURL = urlImage
            self.coordinates.append(latitude)
            self.coordinates.append(longitude)
        
    }
}

typealias Restaurant = [RestaurantElement]
