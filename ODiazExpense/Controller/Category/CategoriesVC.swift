import UIKit

class CategoriesVC: UIViewController {
    var delegate : ReloadData?
    @IBOutlet weak var CategoriesTable: UITableView!
    
    let categoryViewModel = CategoryViewModel()
    var categories = [Category]()
    var category: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesTable.dataSource = self
        CategoriesTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.reloadData()
    }

    func loadData(){
        let result = categoryViewModel.GetAll()
        if result.Correct{
            categories = result.Objects as! [Category]
            CategoriesTable.reloadData()
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Error en la base de datos", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in

            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }

}

extension CategoriesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoriesTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell

        cell.NameCell.text = categories[indexPath.row].Nombre

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        category = categories[indexPath.row]
        performSegue(withIdentifier: "subCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subCategory"{
            let send = segue.destination as! SubCategoryVC
            send.category = self.category
        }
    }
    
}
