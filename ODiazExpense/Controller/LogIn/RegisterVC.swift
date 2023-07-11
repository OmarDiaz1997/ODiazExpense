import UIKit

class RegisterVC: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var imageRegister: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nombreRegister: UITextField!
    @IBOutlet weak var apellidoPaterno: UITextField!
    @IBOutlet weak var apellidoMaterno: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var confirmPasswordRegister: UITextField!
    @IBOutlet weak var fechaNacimientoRegister: UIDatePicker!
    @IBOutlet weak var RegisterActionButton: UIButton!
    
    private let loginViewModel = LogInViewModel()
    private var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func newUser(user: User){
        let result = loginViewModel.Add(usuario: user)
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Usuario registrado", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { (_) in
                 }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Usuario no registrado", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { (_) in
                 }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    @IBAction func imageMenuButton(_ sender: Any) {
        presentPhotoActionSheet()
    }
    
    @IBAction func RegisterButtonAction(_ sender: Any) {
        guard let nombre = nombreRegister.text, nombre != "" else{
            nombreRegister.placeholder = "Ingrese su nombre"
            return
        }
        guard let aPaterno = apellidoPaterno.text, aPaterno != "" else{
            apellidoPaterno.placeholder = "Ingrese su apellido paterno"
            return
        }
        guard let aMaterno = apellidoMaterno.text, aMaterno != "" else{
            apellidoMaterno.placeholder = "Ingrese su apellido materno"
            return
        }
        guard let email = emailRegister.text, email != "" else{
            emailRegister.placeholder = "Ingrese su correo"
            return
        }
        guard let password = passwordRegister.text, password != "" else{
            passwordRegister.placeholder = "Ingrese una contraseña"
            return
        }
        guard let confirmPassword = confirmPasswordRegister.text, confirmPassword != "" else{
            confirmPasswordRegister.placeholder = "Confirme su contraseña"
            return
        }
        
        if nombre != "" && aPaterno != "" && aMaterno != "" && email != "" && password != "" && confirmPassword != "" {
            if password == confirmPassword{
                let image = convertImageToBase64String(img: imageRegister.image!)
                
                user = User(id: 0,
                            imagen: image,
                            nombre: nombre,
                            apellidoPaterno: aPaterno,
                            apellidoMaterno: aMaterno,
                            fechaNacimiento: "",
                            email: email,
                            password: password)
                
                newUser(user: user!)
            }else{
                let alert = UIAlertController(title: "Alerta", message: "Las contraseñas no coinciden", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { (_) in
                     }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
}





extension RegisterVC : UIImagePickerControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Imagen de subcategoría",
                                            message: "Seleccionar foto de de subcategoría",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Tomar foto",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Seleccionar desde la galería",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageRegister.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
