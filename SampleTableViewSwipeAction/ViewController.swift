//
//  ViewController.swift
//  SampleTableViewSwipeAction
//
//  Created by 김호세 on 2022/03/01.
//

import UIKit

class ViewController: UIViewController {
  
  private let tableview: UITableView = {
    let tableview = UITableView(frame: .zero, style: .plain)
    tableview.translatesAutoresizingMaskIntoConstraints = false
    tableview.register(UITableViewCell.self, forCellReuseIdentifier: "tvc")
    tableview.rowHeight = 80
    tableview.estimatedRowHeight = 80
    tableview.backgroundColor = .blue
    return tableview
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Hello World!")
    tableview.delegate = self
    tableview.dataSource = self
    makeUI()
    view.backgroundColor = .white
  }
}

extension ViewController {
  private func makeUI() {
    view.addSubview(tableview)
    NSLayoutConstraint.activate([
      tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tvc", for: indexPath)
    cell.textLabel?.text = "\(indexPath)"
    cell.backgroundColor = .brown
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .normal, title: "first                ") { _, _, success in
      // Escaping Handler - 클릭 후 나타날 이벤트 처리
      success(true)
    }
    let label = UILabel()
    label.text = "FIRSTdsfsdfsdfsdfsfsdfdsf"
    label.font = .systemFont(ofSize: 15)
//    label.frame.size = CGSize(width: 50, height: 50)
//    label.sizeToFit()
    label.layer.cornerRadius = 5
    label.backgroundColor = .red
    
//    delete.backgroundColor = UIColor(white: 1, alpha: 0)
    delete.backgroundColor = .darkGray
    delete.image = UIImage(view: label)
    
    
    let secondAction = UIContextualAction(style: .normal, title: "remove") { _, _, success in
      print("dsf")
      success(true)
    }
    
    secondAction.image = UIGraphicsImageRenderer(size: CGSize(width: 400, height: 90)).image {
      _ in UIImage(systemName: "trash")!.draw(in: CGRect(x: 40, y: 10, width: 400, height: 100))
    }
//    secondAction.backgroundColor = UIColor(white: 1, alpha: 0)
    secondAction.backgroundColor = .black
    
    let action = UIContextualAction(style: .normal, title: "remove") { _, _, success in
      print("dsf")
      success(true)
    }
    action.image = UIImage(systemName: "trash")
    action.title = "dsfdsfsdfsdfdf"
//    action.backgroundColor = UIColor(white: 1, alpha: 0)
    action.backgroundColor = .red
    
    
    
    let config = UISwipeActionsConfiguration(actions: [delete, secondAction, action])
    config.performsFirstActionWithFullSwipe = false
    return config
  }
  
}

extension UIImage {
  
  func addBackgroundCircle(_ color: UIColor?) -> UIImage? {
    
    let circleDiameter = max(size.width * 2, size.height * 2)
    let circleRadius = circleDiameter * 0.5
    let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
    let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
    let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)
    
    let view = UIView(frame: circleFrame)
    view.backgroundColor = color ?? .systemRed
    view.layer.cornerRadius = circleDiameter * 0.5
    
    UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)
    
    let renderer = UIGraphicsImageRenderer(size: circleSize)
    let circleImage = renderer.image { ctx in
      view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
    }
    
    circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
    draw(in: imageFrame, blendMode: .normal, alpha: 1.0)
    
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
  }
}



extension UIImage {
  
  /// This method creates an image of a view
  convenience init?(view: UIView) {
    
    // Based on https://stackoverflow.com/a/41288197/1118398
    let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
    let image = renderer.image { rendererContext in
      view.layer.render(in: rendererContext.cgContext)
    }
    
    if let cgImage = image.cgImage {
      self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
    } else {
      return nil
    }
  }
}


extension UIView {
  var allSubViews : [UIView] {
    var array = [self.subviews].flatMap {$0}
    array.forEach { array.append(contentsOf: $0.allSubViews) }
    return array
  }
}
