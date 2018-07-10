//
//  Geometry.swift
//  scrollablemap
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation

/**
 Vector data representing the shapes of a country
 
 Conforms to **GeoJSON** data structures.
 */
struct Geometry: Codable {
    /**
     Types of geometry:
     * Polygon: for countries represented by a single shape
     * MultiPolygon: for countries represented by a multiple shapes
     */
    let type: String
    
    /**
     The generict bundle of vector coordinates representing the country.
     
     Casting this property is not recomented.
     
     Use `self.polygon` or `self.multiPolygon` instead.
     */
    let coordinates: Any
    
    /**
     The bundle of vector coordinates representing the country shapes.
     
     Returns nil if `self.type != "MultiPolygon"`.
     */
    var polygon: [[[Double]]]? {
        return self.coordinates as? [[[Double]]]
    }
    
    /**
     The bundle of vector coordinates representing the country shape.
     
     Returns nil if `self.type != "Polygon"`.
     */
    var multiPolygon: [[[[Double]]]]? {
        return self.coordinates as? [[[[Double]]]]
    }
    
    //MARK: Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        self.type = type
        
        if type == GeoType.polygon {
            self.coordinates = try container.decode([[[Double]]].self, forKey: .coordinates)
        } else if type == GeoType.multiPolygons {
            self.coordinates = try container.decode([[[[Double]]]].self, forKey: .coordinates)
        } else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.coordinates,
                                                   in: container,
                                                   debugDescription: "Isn't polygon or multipolygon")
        }
    }
    
    //MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        if self.type == GeoType.polygon,
            let polygon = self.polygon {
            try container.encode(polygon, forKey: .coordinates)
        } else if self.type == GeoType.multiPolygons,
            let multiPolygons = self.multiPolygon {
            try container.encode(multiPolygons, forKey: .coordinates)
        }
    }
    
    //MARK: Aux Enums
    private enum GeoType: String {
        case polygon = "Polygon"
        case multiPolygons = "MultiPolygon"
        
        static func ==(left: GeoType, right: String) -> Bool {
            return left.rawValue == right
        }
        
        static func ==(left: String, right: GeoType) -> Bool {
            return left == right.rawValue
        }
        
        static func !=(left: GeoType, right: String) -> Bool {
            return left.rawValue != right
        }
        
        static func !=(left: String, right: GeoType) -> Bool {
            return left != right.rawValue
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}
