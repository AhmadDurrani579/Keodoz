//
//  KDListCoachVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import GoogleMaps

class KDListCoachVC: UIViewController , CLLocationManagerDelegate , GMSMapViewDelegate {
    @IBOutlet var viewOfMaps: GMSMapView!
    @IBOutlet var tblView: UITableView!
    @IBOutlet var txtSearch: UITextField!
    var latitude :  Double?
    var lngitude :  Double?
    var serviceSelect : ServiceList?
    private var coachList : [CoachList] = []
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    var index:Int!
    var bounds = GMSCoordinateBounds()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([CoachListCell.self])
        txtSearch.setLeftPaddingPoints(10.0)
        viewOfMaps.tintColor = UIColor.red
        
        self.viewOfMaps.settings.myLocationButton = true
        let mapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0.0 , right: 0.0)
        self.viewOfMaps.padding = mapInsets
        viewOfMaps.delegate = self;
        self.viewOfMaps.settings.zoomGestures = true
        self.viewOfMaps.mapType = GMSMapViewType(rawValue: 3)!

        setDefaultLocationOnMap()
        getAllTheCoachList()
    }
    
    func setupUI() {
        
        self.viewOfMaps.delegate = self
        self.viewOfMaps?.isMyLocationEnabled = true
        self.viewOfMaps.mapType = GMSMapViewType(rawValue: 1)!
        self.viewOfMaps.settings.compassButton = true
        self.viewOfMaps.settings.zoomGestures = true
    }
    
    func setDefaultLocationOnMap() {
        if self.latitude != nil  && self.lngitude != nil {
            setLocationOnMap(lat: self.latitude!, long: self.lngitude!)
        }else {
            _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { location in
                print("loc \(location.coordinate.longitude)\(location.coordinate.latitude)")
                DEVICE_LAT = location.coordinate.latitude
                DEVICE_LONG = location.coordinate.longitude
                self.latitude = DEVICE_LAT
                self.lngitude = DEVICE_LONG
                self.viewOfMaps.settings.compassButton = true
                let mapInsets = UIEdgeInsets(top: 120  , left: 0.0, bottom: 0.0 , right: 0.0)
                self.viewOfMaps.padding = mapInsets
                //setting location on map
                
                self.setLocationOnMap(lat: self.latitude!, long: self.lngitude!)
                
            }) { (last, error) in
                
                print("Something bad has occurred \(error)")
                
                //setting location on map
                self.setLocationOnMap(lat: DEVICE_LAT, long: DEVICE_LONG)
                
            }
        }
    }
    
        func setLocationOnMap(lat: Double, long: Double) {
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.viewOfMaps.settings.compassButton = true
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18)
                self.viewOfMaps.camera = camera
            })
            self.viewOfMaps.settings.myLocationButton = false
        }
    
    @IBAction func btnMap_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            self.tblView.isHidden = false
            self.viewOfMaps.isHidden = true
            self.tblView.reloadData()
        } else {
            self.tblView.isHidden = true
            self.viewOfMaps.isHidden = false
        }

    }

    func getAllTheCoachList() {
        let serviceId = serviceSelect?.id
        
        let endPointss = "\(COACH_SERVICE)serviceCategoryId=\(serviceId!)&latitude=\(DEVICE_LAT)&longitude=\(DEVICE_LONG)"
        let endPoint = AuthEndpoint.coachList(serviceCategoryId: "\(serviceId!)", latitude: "\(DEVICE_LAT)", longitude: "\(DEVICE_LONG)")
          let context = (self)
          showProgressIndicator(view: self.view)
          NetworkLayer.fetchPost(endPoint , url: endPointss, with: ServiceCoach.self) {[weak self] (result) in
          switch result {
           case .success(let response):
            hideProgressIndicator(view: context.view)
           if response.status == true {
            context.coachList = response.data ?? []
            for (index , obj) in (context.coachList.enumerated()) {
                let latOfRestaurent = Double(obj.latitude!)
                let lngOfRestaurent = Double(obj.longitude!)
                let marker = GMSMarker()
                let camera = GMSCameraPosition.camera(withLatitude : latOfRestaurent!  , longitude: lngOfRestaurent! , zoom: 13.0)
                self!.viewOfMaps.camera = camera
                marker.accessibilityLabel = "\(index)"
                marker.position = CLLocationCoordinate2D(latitude: latOfRestaurent! , longitude: lngOfRestaurent!)
                let markerImage = UIImage(named: "locIcon")!.withRenderingMode(.alwaysTemplate)
                let markerView = UIImageView(image: markerImage)
                 marker.icon = markerView.image
                self!.bounds = self!.bounds.includingCoordinate(marker.position)
                marker.map = self!.viewOfMaps
                let update = GMSCameraUpdate.fit(self!.bounds, withPadding: 120.0)
                self!.viewOfMaps.animate(with: update)

            }
                context.tblView.delegate = self
                context.tblView.dataSource = self
                context.tblView.reloadData()
                let cameras = GMSCameraPosition.camera(withLatitude: DEVICE_LAT , longitude: DEVICE_LONG , zoom: 13.0)
                self!.viewOfMaps.camera = cameras

            
           } else {
                context.showToast(response.message)
           }
            case .failure(_):
                hideProgressIndicator(view: context.view)

                context.showToast("Server Error")
                
                break
            }
        }
    }
}

extension KDListCoachVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coachList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CoachListCell.self, for: indexPath)
        cell.setCellData(obj: coachList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDServiceDetailVC") as? KDServiceDetailVC else {
            return
        }
        vc.coach = coachList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
