//
//  EntrantPassCardView.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/23/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

final class EntrantPassCardView: UIView {
    fileprivate lazy var entrantNameLabel = UILabel()
    fileprivate lazy var passTypeLabel = UILabel()
    fileprivate lazy var passBenefitsLabel = UILabel()
    let entrantPhoto: UIImageView = UIImageView(image: UIImage(named: "FaceImageAsset.png"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(with entrant: Entrant) {
        super.init(frame: .zero)
        setupProperties()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupHierarchy() {
        addSubview(entrantNameLabel)
        addSubview(passTypeLabel)
        addSubview(passBenefitsLabel)
        addSubview(entrantPhoto)
    }
    
    func setupProperties() {
        backgroundColor = .white
        entrantNameLabel.text =  "homeView/hello.label"
    }
    
    func setupConstraints() {
        
    }
}
