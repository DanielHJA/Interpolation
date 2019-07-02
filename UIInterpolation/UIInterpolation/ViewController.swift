//
//  ViewController.swift
//  UIInterpolation
//
//  Created by Daniel Hjärtström on 2019-05-07.
//  Copyright © 2019 Sog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let temp = UIButton()
        temp.setTitle("Ok", for: .normal)
        temp.setTitleColor(UIColor.white, for: .normal)
        temp.backgroundColor = UIColor.blue
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOffset = CGSize(width: 5, height: 5)
        temp.layer.shadowRadius = 8
        temp.layer.shadowOpacity = 0.8
        temp.addMotionEffect(effectGroup)
        view.insertSubview(temp, aboveSubview: tableView)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
        return temp
    }()
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.tableFooterView = UIView()
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return temp
    }()
    
    // Position
    private lazy var horizontalEffect: UIInterpolatingMotionEffect = {
        let temp = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        temp.minimumRelativeValue = -22
        temp.maximumRelativeValue = 22
        return temp
    }()

    private lazy var verticalEffect: UIInterpolatingMotionEffect = {
        let temp = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        temp.minimumRelativeValue = -22
        temp.maximumRelativeValue = 22
        return temp
    }()
    
    // Shadow effect
    private lazy var horizontalShadowEffect: UIInterpolatingMotionEffect = {
        let temp = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", type: .tiltAlongHorizontalAxis)
        temp.minimumRelativeValue = 22
        temp.maximumRelativeValue = -22
        return temp
    }()
    
    private lazy var verticalShadowEffect: UIInterpolatingMotionEffect = {
        let temp = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", type: .tiltAlongVerticalAxis)
        temp.minimumRelativeValue = 22
        temp.maximumRelativeValue = -22
        return temp
    }()
    
    private lazy var effectGroup: UIMotionEffectGroup = {
        let temp = UIMotionEffectGroup()
        temp.motionEffects = [horizontalShadowEffect, verticalShadowEffect, verticalEffect, horizontalEffect]
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        button.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.frame.height / 2
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = CGFloat(indexPath.row * 3)
        cell.backgroundColor = UIColor.rgb(red: 205 + index, green: 180 + index, blue: 118 + index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return .init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
