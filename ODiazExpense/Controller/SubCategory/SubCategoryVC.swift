//
//  SubCategoryVC.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import UIKit

class SubCategoryVC: UIViewController {
    @IBOutlet weak var SubCategoryTable: UITableView!
    
    var category: Category? = nil
    private var subCategories = [SubCategory]()
    private var subCategoryViewModel = SubCategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category?.Nombre
        SubCategoryTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        let result = subCategoryViewModel.GetAllByCategory(id: category!.Id)
        if result.Correct{
            subCategories = result.Objects as! [SubCategory]
            SubCategoryTable.reloadData()
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Error en la base de datos", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in

            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subCategoryNew"{
            let send = segue.destination as! SubcategoryNewVC
            send.id = self.category?.Id
        }
    }
    
}


extension SubCategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell", for: indexPath)
        
        cell.textLabel?.text = subCategories[indexPath.row].Nombre

        return cell
    }
    
}
