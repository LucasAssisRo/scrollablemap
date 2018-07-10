//
//  Country.swift
//  scrollablemap
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation

/**
 A country with its Metadata and geometry representation.
 
 Conforms to **GeoJSON** data structures.
 */
struct Country: Codable {
    /**
     Type of the country.
     
     Should always be `"Feature"`.
     */
    let type: String
    
    /**
     Bundle with country metadata.
     */
    let properties: Properties
    
    /**
     Bundle with country geometry representation.
     */
    let geometry: Geometry
}
