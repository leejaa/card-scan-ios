import SwiftUI
import Firebase
import FirebaseStorage

public class StorageManager: ObservableObject {
    let storage = Storage.storage()

    func upload(image: UIImage, onSuccess: @escaping(_ url: String) -> Void) {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let fileName = formatter.string(from: Date())
        // Create a storage reference
        let storageRef = storage.reference().child("images/\(fileName).jpg")
        
        let ref = storageRef.child("images/\(fileName).jpg")

        // Resize the image to 200px with a custom extension
//        let resizedImage = image.aspectFittedToHeight(200)

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)

        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("업로드 완료....")

                    storageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                          // Uh-oh, an error occurred!
                          return
                        }
                        print("downloadURL: \(downloadURL)")
                    }
                }
            }
        }
    }
}
