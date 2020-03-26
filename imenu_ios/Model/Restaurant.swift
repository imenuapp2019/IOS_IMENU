import Foundation

// MARK: - RestaurantElement
struct RestaurantElement: Codable {
    let id: Int?
    let nombre, descripcion, direccion: String?
    let latitud, longitud: Double?
    let telefono: Int?
    let tipo: String?
    let imagenes: [Imagene]?
    let rrss: [Rrss]?
    let menu: [Menu]?

    enum CodingKeys: String, CodingKey {
        case id, nombre, descripcion, direccion, latitud, longitud, telefono, tipo, imagenes
        case rrss = "RRSS"
        case menu = "Menu"
    }

    init(id: Int?, nombre: String?, descripcion: String?, direccion: String?, latitud: Double?, longitud: Double?, telefono: Int?, tipo: String?, imagenes: [Imagene]?, rrss: [Rrss]?, menu: [Menu]?) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.direccion = direccion
        self.latitud = latitud
        self.longitud = longitud
        self.telefono = telefono
        self.tipo = tipo
        self.imagenes = imagenes
        self.rrss = rrss
        self.menu = menu
    }
    
    func urlImage() -> String {
        guard let url = imagenes?[0].url else{ return "https://images.pexels.com/photos/326279/pexels-photo-326279.jpeg"}
        return url
    }
}

typealias Restaurant = [RestaurantElement]
