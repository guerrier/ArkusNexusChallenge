//
//  PlaceViewCell.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import HCSStarRatingView

public class PlaceViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: HCSStarRatingView!
    @IBOutlet weak var addressLine1: UILabel!
    @IBOutlet weak var addressLine2: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var iconPetFriendly: UIImageView!
    @IBOutlet weak var labelPetFriendly: UILabel!
    
    private var cellModel:PlaceModel?
    
    public func configure(_ model: PlaceModel){
        cellModel = model
        name.text = cellModel?.placeName
        rating.value = CGFloat(cellModel?.rating ?? 0.0)
        addressLine1.text = cellModel?.addressLine1
        addressLine2.text = cellModel?.addressLine2
        if (cellModel?.distance)! >= 1000.0 {
            let formatter:MeasurementFormatter = MeasurementFormatter()
            let distanceinKM:Measurement = Measurement(value: (cellModel?.distance)!, unit: UnitLength.meters)
            
            formatter.unitStyle = MeasurementFormatter.UnitStyle.short
            formatter.locale = Locale(identifier: "es_MX")
            distance.text = formatter.string(from: distanceinKM)
        } else {
            distance.text = (cellModel?.distance.description)! + " m"
        }
        let isPetFriendly:Bool = cellModel!.isPetFriendly
        iconPetFriendly.isHidden = !isPetFriendly
        labelPetFriendly.isHidden = !isPetFriendly
        
        let url:URL = URL(string: cellModel!.thumbnail)!
        let placeholderImage = UIImage(named: "placeholder")!
        
        thumbnail.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
        
        
        
        
}
