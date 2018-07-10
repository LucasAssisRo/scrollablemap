//
//  ViewController.swift
//  scrollablemap
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

/**
 View controller with draggable and zoomable map.
 */
class MapViewController: UIViewController {
    /**
     ScrollView to handle map dragging motions.
     */
    @IBOutlet weak var scrollView: UIScrollView!
    
    /**
     View to hold the map drawings
     */
    var mapView: MapView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Used viewDidAppear to make sure constraints have been processed
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Loads GeoJSON and loads the map
        guard let path = Bundle.main.path(forResource: "countries_small", ofType: "geojson") else { return }
        if self.mapView == nil {
            self.mapView = MapView(frame: self.scrollView.bounds)
            self.mapView.backgroundColor = .white
            self.scrollView.addSubview(self.mapView)
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let json = try Data(contentsOf: url)
            self.mapView.world = try JSONDecoder().decode(World.self, from: json)
            self.mapView.transform = self.mapView.transform.scaledBy(x: 2, y: 2)
            self.mapView.frame.origin = .zero
            self.scrollView.contentSize = self.mapView.frame.size
        } catch {
            print(error.localizedDescription)
        }
        
        //Initial map position
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentSize.width / 2 - self.scrollView.bounds.width / 2,
                                                 y: self.scrollView.contentSize.height / 2 - self.scrollView.bounds.height / 2),
                                         animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: UIScrollViewDelegate {
    //Handle the zooming in and out
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapView
    }
}

