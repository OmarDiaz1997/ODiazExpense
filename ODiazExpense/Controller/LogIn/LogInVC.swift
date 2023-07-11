import UIKit

class LogInVC: UIViewController {
    @IBOutlet weak var ImageLogIn: UIImageView!
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [
//            UIColor.systemPurple.cgColor,
//            UIColor.systemPink.cgColor,
//            UIColor.white.cgColor
//        ]
        
        ImageLogIn?.layer.cornerRadius = (ImageLogIn?.frame.size.width ?? 0.0) / 2
        ImageLogIn?.clipsToBounds = true
        ImageLogIn?.layer.borderWidth = 3.0
        ImageLogIn?.layer.borderColor = UIColor.white.cgColor
        
        //view.layer.addSublayer(gradientLayer)
    }
    
    func logIn(){
        
    }
    
    @IBAction func LogInActionButton(_ sender: Any) {
        guard let email = emailLogin.text, email != "" else{
            emailLogin.placeholder = "Ingrese un correo electronico"
            return
        }
        guard let password = passwordLogin.text, password != "" else{
            passwordLogin.placeholder = "Ingrese su password"
            return
        }
    }
    
}
