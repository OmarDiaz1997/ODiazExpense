import UIKit

protocol ReloadData{
    func reloadData()
}

class CategoryNewVC: UIViewController {
    var delegate : ReloadData?
    
    @IBOutlet weak var nombreCategorie: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    
    let categorieViewModel = CategoryViewModel()
    var categorieModel: Category? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    func createCategorie(categorie: Category) {
        let result = categorieViewModel.Add(categorie: categorie)
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Categoria agregada correctamente", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                self.nombreCategorie.text = ""
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Departamento no agregado", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in

            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }

    @IBAction func AddButtonAction(_ sender: Any) {
        guard let nombre = nombreCategorie.text, nombre != "" else{
            nombreCategorie.placeholder = "Ingrese el nombre de la categoria"
            return
        }
        
        categorieModel = Category(Id: 0, Nombre: nombre)
        createCategorie(categorie: categorieModel!)
        delegate?.reloadData()
        
        
    }
    
}
