import Foundation
import UIKit
import iOSDropDown

class MovementVC: UIViewController {
    let idUser = UserDefaults.standard.integer(forKey: "idUser")

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var monto: UITextField!
    
    @IBOutlet weak var optionSegment: UISegmentedControl!
    var tipoMovimiento = 0
    @IBAction func tipo(_ sender: Any) {
        if optionSegment.selectedSegmentIndex == 0 {
            tipoMovimiento = 0
        }else if optionSegment.selectedSegmentIndex == 1 {
            tipoMovimiento = 1
        }
    }
    
    @IBOutlet weak var categoria: DropDown!
    @IBOutlet weak var subCategoria: DropDown!
    
    private let movimientoViewModel = MovimientoViewModel()
    var movimientoModel: Movimiento? = nil
    
    private let categoryViewModel = CategoryViewModel()
    private let subCategoryViewModel = SubCategoryViewModel()
    private var subCategory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoria.optionArray = [String]()
        categoria.optionIds = [Int]()
        subCategoria.optionArray = [String]()
        subCategoria.optionIds = [Int]()
        LoadDatacategory()
        
        categoria.didSelect { selectedText, index, id in
            self.LoadDataSubCategory(id)
        }
        subCategoria.didSelect { selectedText, index, id in
            self.subCategory = id
        }
    }
    
    func LoadDatacategory(){
        let result = categoryViewModel.GetAll()
        if result.Correct{
            for category in result.Objects as! [Category]{
                categoria.optionArray.append(category.Nombre)
                categoria.optionIds?.append(category.Id)
            }
        }
    }
    
    func LoadDataSubCategory(_ IdArea : Int){
        let result = subCategoryViewModel.GetAllByCategory(id: IdArea)
            if result.Correct{
                subCategoria.optionArray = [String]()
                subCategoria.optionIds = [Int]()
                for departamento in result.Objects as! [SubCategory]{
                    subCategoria.optionArray.append(departamento.Nombre)
                    subCategoria.optionIds?.append(departamento.Id)
                }
            }
        }
    
    func addMovimiento(movimiento: Movimiento){
        
    }

    @IBAction func addActionButton(_ sender: Any) {
        guard let Nombre = nombre.text, Nombre != "" else{
            nombre.placeholder = "Ingrese el nombre del movimiento"
            return
        }
        guard let Monto = monto.text, Monto != "" else{
            monto.placeholder = "Ingrese el monto"
            return
        }
        var montoValidate = 0.0
        if let montoDouble = Double(Monto){
            print("Monto correcto: \(montoDouble)")
            montoValidate = montoDouble
        }else{
            monto.text = ""
            monto.placeholder = "Debe de ingresar un numero"
        }
        
        movimientoModel = Movimiento(id: 0,
                                     nombre: Nombre,
                                     fecha: Date(),
                                     monto: montoValidate,
                                     tipo: tipoMovimiento,
                                     idSubCategoria: subCategory,
                                     idUsuario: idUser)
        
        let result = movimientoViewModel.Add(movimiento: movimientoModel!)
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Movimiento agregado", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                self.nombre.text = ""
                self.monto.text = ""
                self.tipoMovimiento = 0
            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Movimiento no agregado", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
        

    }
    
}
