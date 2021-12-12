//
//  ViewController.swift
//  hotdogOrNotHotdog
//
//  Created by Yash on 12/1/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let imagePicker = UIImagePickerController()
    
    var  result: [VNClassificationObservation] = []
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
    
    
    
    
    imagePicker.sourceType = .camera
    imagePicker.allowsEditing = false
    
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        
        
        
        
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfodidFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any])  {
    
    
    
    
    if let image = info[.originalImage] as? UIImage {
        
        
        imageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        guard let ciImage = CIImage(image : image) else {return}
        
        detect(image : ciImage)
        
        
    }
        
        
    
}
    
func detect(image : CIImage) {
    
    
    if let model = try? VNCoreMLModel(for : Inceptionv3().model){
    
        
        let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {return}
            
            
            if topResult.identifier.contains("hotdog") {
                
                DispatchQueue.main.async {
                    
                    self.navigationItem.title = " Hotdog "
                }
            }
            
            else {
                
                
                DispatchQueue.main.sync {
                    self.navigationItem.title = " Not Hotdog "
                }
            }
        })
    
        
        let handler = VNImageRequestHandler(ciImage : image)
        do {
            try
            handler.perform([request])
        }
        catch {
            
            print(error)
        }
        
        
        
    
    
        
        
        
        
    
        
    }
    
    



}

}
