import UIKit

class CategoryVC: UIViewController {
    @IBOutlet weak var CategoriesTable: UITableView!
    
    let categoryViewModel = CategoryViewModel()
    let subCategoryViewModel = SubCategoryViewModel()
    var categories: [[SubCategory]] = []
    var names = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesTable.dataSource = self
        //CategoriesTable.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier: "CategoryCell")
        //CategoriesTable.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        //CategoriesTable.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        //CategoriesTable.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        categories = []
        names = []
    }
    
    func loadData(){
        let result = categoryViewModel.GetAll()
        if result.Correct{
            names = result.Objects as! [Category]
            loadDataSubCategory()
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "A surgido un error en la base de datos", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }
    
    func loadDataSubCategory(){
        for i in 0...names.count - 1 {
            let result = subCategoryViewModel.GetAllByCategory(id: names[i].Id)
            if result.Correct{
                let arraySubCategory = result.Objects as! [SubCategory]
                categories.append(arraySubCategory)
            }
        }
        CategoriesTable.reloadData()
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
}


extension CategoryVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        names.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let model = categories[indexPath.section][indexPath.row]
        let image = convertBase64StringToImage(imageBase64String: model.Imagen)
        cell.ImageCategory.image = image
        cell.NameCategory.text = model.Nombre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return names[section].Nombre
    }
    
}


extension CategoryVC: ReloadData{
    func reloadData() {
        self.loadData()
    }
}
