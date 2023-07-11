import UIKit

class ExpenseVC: UIViewController {
    @IBOutlet weak var TotalBalance: UILabel!
    @IBOutlet weak var FechaBalance: UILabel!
    @IBOutlet weak var IngresosBalance: UILabel!
    @IBOutlet weak var EgresosBalance: UILabel!
    
    @IBOutlet weak var MovimientoTableView: UITableView!
    
    let defaults = UserDefaults.standard
    let id = UserDefaults.standard.integer(forKey: "idUser")
    private let userViewModel = UserViewModel()
    private let movimientoViewModel = MovimientoViewModel()
    private let subCategoryViewModel = SubCategoryViewModel()
    var movimientos = [Movimiento]()
    
    var TOTAL = 0.0
    var fecha = Date()
    var egresos = 0.0
    var ingresos = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovimientoTableView.dataSource = self
        MovimientoTableView.delegate = self
//        MovimientoTableView.rowHeight = 100

        let session = defaults.integer(forKey: "idUser")
        if session == 0 {
            getUser()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    func getUser(){
        let result = userViewModel.GetUser(id: 1)
        if result.Correct{
            let model = result.Object as! User
            defaults.set(model.id, forKey: "idUser")
        }else{
            print("Error en la base de datos")
        }
    }
    
    func getImage(with idSubcategory: Int) -> UIImage{
        var image = UIImage()
        let result = subCategoryViewModel.GetById(id: idSubcategory)
        if result.Correct{
            let model = result.Object as! SubCategory
            let imageString = model.Imagen
            image = convertBase64StringToImage(imageBase64String: imageString)
        }
        return image
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func loadData(){
        let result = movimientoViewModel.GetAllByUser(idUser: id)
        if result.Correct{
            movimientos = result.Objects as! [Movimiento]
            balance()
            TotalBalance.text = "$\(TOTAL)"
            EgresosBalance.text = "$\(egresos)"
            IngresosBalance.text = "$\(ingresos)"
            FechaBalance.text = "\(Date())"
            
            MovimientoTableView.reloadData()
        }else{
            
        }
    }
    
    func balance(){
        for i in 0...movimientos.count - 1 {
            if movimientos[i].tipo == 0 {
                egresos = egresos + movimientos[i].monto
            }else{
                ingresos = ingresos + movimientos[i].monto
            }
            TOTAL = ingresos - egresos
        }
    }

}

extension ExpenseVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movimientos.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseCell
        let model = movimientos[indexPath.row]
        
        cell.layer.cornerRadius = 8
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell.ImageExpenseCell.image = getImage(with: model.id)
        cell.NameExpenseCell.text = "   \(model.nombre)"
        cell.DateExpenseCell.text = "   \(model.fecha)"
        if model.tipo == 0 {
            cell.MontoExpenseCell.textColor = .red
            cell.MontoExpenseCell.text = "$ -\(model.monto)   "
        }else if model.tipo == 1 {
            cell.MontoExpenseCell.textColor = .green
            cell.MontoExpenseCell.text = "$ \(model.monto)   "
        }else{
            print("Ay error en el tipo de movimiento (ingreso o egreso)")
        }
        
        return cell
    }
    
}
