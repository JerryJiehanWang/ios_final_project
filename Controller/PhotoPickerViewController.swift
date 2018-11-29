import UIKit

class PhotoPickerViewController: PickerViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var model = TransferStyle()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var pickerBtn: UIButton!
    
    @IBAction func pickerBtnAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true)
        } else {
            print("Photo Library not available")
        }
        // openOptions()
    }
    
    @IBAction func preview(_ sender: Any) {
        performSegue(withIdentifier: "toPost", sender: self)
    }
    override func selectedImage(choosenImage: UIImage) {
        imageView.image=choosenImage
    }
    
    @IBAction func transfer() {
        guard let image = self.imageView.image else {
            print("Select an image first")
            return
        }
        
        model.process(input: image) { filteredImage in
            if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
            }
        }
    }
}
