import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var ImageProfile: UIImageView!
    @IBOutlet weak var FullNameProfile: UILabel!
    @IBOutlet weak var FechaProfile: UILabel!
    
    private var userViewModel = UserViewModel()
    let session = UserDefaults.standard.integer(forKey: "idUser")

    override func viewDidLoad() {
        super.viewDidLoad()
        ImageProfile?.layer.cornerRadius = (ImageProfile?.frame.size.width ?? 0.0) / 2
        ImageProfile?.clipsToBounds = true
        ImageProfile?.layer.borderWidth = 3.0
        ImageProfile?.layer.borderColor = UIColor.white.cgColor
        if session != 0{
            loadProfile()
        }
    }
    
    private func loadProfile(){
        let result = userViewModel.GetUser(id: session)
        if result.Correct{
            let model = result.Object as! User
            let image = convertBase64StringToImage(imageBase64String: model.imagen)
            ImageProfile.image = image
            FullNameProfile.text = "Nombre: \(model.nombre) \(model.apellidoPaterno) \(model.apellidoMaterno)"
            FechaProfile.text = model.fechaNacimiento
        }else{
            print("Error de sesion")
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
}
