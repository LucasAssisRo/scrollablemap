//
//  MapView.swift
//  scrollablemap
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

/**
 UIView subclass that draws a map.
 
 Needs to set the `world` property before anything is drawn.
 */
class MapView: UIView {
    /**
     Bezier path containing the world shapes.
     */
    private var map = UIBezierPath()
    
    /**
     Layer containing the world drawing.
     */
    var mapLayer = CAShapeLayer()
    
    /**
     World metadata bundle.
     
     Needs to be set before any drawing is made.
     */
    var world: World? {
        didSet {
            self.loadMap()
        }
    }
    
    /**
     Processes the worlds metadata and draws the countries.
     
     Doesn't  do anything if `self.world == nil`.
     */
    private func loadMap() {
        guard let world = self.world else { return }
        let center = CGPoint(x: self.bounds.midX, y: 0)
        
        //Load country shapes
        for country in world.countries {
            
            //Check for country type
            if let coordinatesMatrix = country.geometry.polygon {
                for coordinates in coordinatesMatrix {
                    self.map.move(to:self.getScreenCoordinates(from: coordinates[0]) - center)
                    for coordinate in coordinates {
                        self.map.addLine(to: self.getScreenCoordinates(from: coordinate) - center)
                    }
                }
            } else if let coordinatesCube = country.geometry.multiPolygon {
                for coordinatesMatrix in coordinatesCube {
                    for coordinates in coordinatesMatrix {
                        self.map.move(to:self.getScreenCoordinates(from: coordinates[0]) - center)
                        for coordinate in coordinates {
                            self.map.addLine(to: self.getScreenCoordinates(from: coordinate) - center)
                        }
                    }
                }
            }
        }
        
        
        //Draw countries
        self.map.apply(CGAffineTransform(translationX: -self.map.bounds.minX, y: -self.map.bounds.minY))
        self.mapLayer.path = self.map.cgPath
        self.mapLayer.fillColor = UIColor.darkGray.cgColor
        self.mapLayer.strokeColor = UIColor.lightGray.cgColor
        self.mapLayer.lineWidth = 0.1
        self.frame = self.mapLayer.frame
        self.layer.addSublayer(self.mapLayer)
        self.bounds.size = self.map.bounds.size
        self.frame.origin = .zero
    }
    
    /**
     Processes **GeoJSON** coordinates to be used with Core Graphics for drawing the world.
     - parameter geoCoodinates: Coordinates to be converted.
     - returns: `CGPoint` to be used for the drawings. If no world was set or geoCoordinates array size is diferent than 2 returns `.zero`.
     */
    private func getScreenCoordinates(from geoCoordinates: [Double]) -> CGPoint {
        guard let world = self.world, geoCoordinates.count == 2 else { return .zero }
        let boundingBox = world.boundingBox
        let normalizedBoundSize = CGSize(width: self.bounds.size.height * world.aspectRatio,
                                         height: self.bounds.size.height)
        let lng1 = boundingBox[0]
        let lng2 = boundingBox[2]
        let lngC = geoCoordinates[0]
        let x = normalizedBoundSize.width * CGFloat(1 - (lng2 - lngC) / (lng2 - lng1))
        
        let lat1 = boundingBox[1]
        let lat2 = boundingBox[3]
        let latC = geoCoordinates[1]
        let y = normalizedBoundSize.height * CGFloat((lat2 - latC) / (lat2 - lat1))
        
        return CGPoint(x: x, y: y)
    }
}
