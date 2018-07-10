//
//  World.swift
//  scrollablemap
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

/**
 A world with all its countries.
 
 Conforms to **GeoJSON** data structures.
 */
struct World : Codable {
    /**
     The worlds bounding box.
     * Min longitude - 0
     * Min latitude - 1
     * Max longitude - 2
     * Max latitude - 3
     */
    var boundingBox: [Double]
    
    /**
     Type of the world.
     
     Should always be `"FeatureCollection"`.
     */
    var type: String
    
    /**
     List of countries.
     */
    var countries: [Country]
    
    /**
     The aspect ratio of the world bounding box.
     
     x:y
     */
    var aspectRatio: CGFloat {
        let width = CGFloat(self.boundingBox[2] - self.boundingBox[0])
        let height = CGFloat(self.boundingBox[3] - self.boundingBox[1])
        return width / height
    }
    
    private enum CodingKeys: String, CodingKey {
        case boundingBox = "bbox"
        case type
        case countries = "features"
    }
}
