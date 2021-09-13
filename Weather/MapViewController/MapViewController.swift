//
//  MapViewController.swift
//  Weather
//
//  Created by Дмитрий  on 10.09.2021.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    lazy var locations = [CLLocation]()
    let locationManager = CLLocationManager()
    var presenter: TemperaturePresenterProtocol!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        navigationController?.navigationBar.barTintColor = UIColor.green
        mapView.delegate = self
    }
    
    @IBAction func myGeolocationButtonPressed(_ sender: UIButton) {
        
        guard let currentLocation = locations.last else {return}
            render(currentLocation)
    }
    
    
    private func getLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        locationManager.startUpdatingLocation()
    }
    
    private func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let coordinateBristol = CLLocationCoordinate2D(latitude: 51.4552, longitude: -2.59665)
        let coordinateBrimingham = CLLocationCoordinate2D(latitude: 52.4814, longitude: -1.89983)
        
        let span = MKCoordinateSpan(latitudeDelta: 1.4, longitudeDelta: 1.4)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pinСurrentCity = AnnotationPin(title: "London", subtitle: "Capital of the GB", coordinate: coordinate)
        
        let pinBristol = AnnotationPin(title: "Bristol", subtitle: "Perfect city", coordinate: coordinateBristol)
        let pinBrimingham = AnnotationPin(title: "Birmingham", subtitle: "Also perfect city", coordinate: coordinateBrimingham)
        
        mapView.addAnnotations([pinСurrentCity, pinBristol, pinBrimingham])
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations = locations
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MKPinAnnotationView")
        anotationView.image = #imageLiteral(resourceName: "TooltipBody")
        anotationView.image = anotationView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        anotationView.tintColor = (UIColor(named: "backgroundCellGray") ?? .white)
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forReqquesType: .city(city: (annotation.title ?? "Moscow") ?? "Moscow")) { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    anotationView.feelsLikeLabel.text = Int(weatherData.list[0].main.temp).description
                    anotationView.temperatureLabel.text = Int(weatherData.list[0].main.feelsLike).description
                }
            case .failure(let error):
                print(error)
            }
        }

        
        let transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        anotationView.transform = transform
        return anotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        presenter.getLists(requesType: .city(city: (view.annotation?.title ?? "Moscow") ?? "Moscow"))
        navigationController?.popToRootViewController(animated: true)
    }
}
