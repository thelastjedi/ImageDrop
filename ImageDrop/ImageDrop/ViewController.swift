//
//  ViewController.swift
//  ImageDrop
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var bottomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allowDropInImages(imageView: topImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:
    
    func allowDropInImages(imageView: UIImageView) {
        let dropInteraction = UIDropInteraction(delegate: imageView)
        imageView.addInteraction(dropInteraction)
        imageView.isUserInteractionEnabled = true
    }
    
    func removeDropInImages(imageView: UIImageView) {
        for interaction in imageView.interactions {
            imageView.removeInteraction(interaction)
        }
    }
    
}

extension UIImageView: UIDropInteractionDelegate {
    
    public func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: self.superview!)
        let operation: UIDropOperation
        
        if self.frame.contains(dropLocation) {
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]
            self.image = images.first!
        }
    }
    
}
