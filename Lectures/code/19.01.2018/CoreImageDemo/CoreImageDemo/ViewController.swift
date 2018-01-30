//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by Emil Atanasov on 19.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        //https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346
        
        let filter = CIFilter(name: "CIGaussianBlur")
        
        
        if let _ = imageView.image?.ciImage {
            print("has CIImage")
        }
        
        
        if let _ = imageView.image?.cgImage {
            print("has CGImage")
        }
        
        let ciImage = CIImage(cgImage: (imageView.image?.cgImage!)!)
        
        filter?.setValue(ciImage, forKey: "inputImage")
//        filter?.setValue(CIColor.black, forKey: "inputColor")
//        filter?.setValue(1.0, forKey: "inputIntensity")
        
        let context = CIContext()
        
//        context.
        
        
        if let outputImage = filter?.outputImage {
            
            print("???")
            
            imageView.image = UIImage(cgImage: context.createCGImage(outputImage, from: ciImage.extent)!)
        }
    }
    

}

