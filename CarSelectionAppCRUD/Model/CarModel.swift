//
//  CarModel.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import Foundation
import FirebaseFirestoreSwift

struct Car: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var brandName: String
    var modelName: String
    var engineName: String
    var transmissionName: String
    var year: String
    var imageUrl: String
    var price: Int
    var driveUnit: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case brandName
        case modelName
        case engineName
        case transmissionName
        case year
        case imageUrl
        case price
        case driveUnit
    }
}

extension Car {
    static var dummyData: Car {
        .init(brandName: "BMW",
              modelName: "X5 M",
              engineName: "40d 3.0d AT (340 л.с.) 4WD",
              transmissionName: "Автомат",
              year: "2022",
              imageUrl: "https://www.allcarz.ru/wp-content/uploads/2022/04/foto-x7-2023_04.jpg",
              price: 8900000,
              driveUnit: "Полный")
    }
}
