//
//  StorageService.swift
//  HereThere2
//
//  Created by 우소연 on 02/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

struct StorageServiceFireBase {
   /*
    
    // provide method for uploading images
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        reference.putData(imageData, metadata: metaData, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("Upload failed :: ",error.localizedDescription)
                return completion(nil)
            }
            
            completion(metadata?.downloadURL())
        })
    }*/
}
