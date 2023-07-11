//
//  SubcategoryManagerVC.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import UIKit

class SubcategoryNewVC: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var ImageSubCategory: UIImageView!
    @IBOutlet weak var NameSubCategory: UITextField!
    @IBOutlet weak var ButtonSubCategory: UIButton!
    
    private let subCategoryViewModel = SubCategoryViewModel()
    private var subCategoryModel: SubCategory? = nil
    var id: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    @IBAction func ButtonActionMenuCamera(_ sender: Any) {
        presentPhotoActionSheet()
    }
    
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {

       let size = CGSize(width: 0, height: 0)
       if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    @IBAction func ButtonActionSubCategory(_ sender: Any) {
        guard let nombre = NameSubCategory.text, nombre != "" else{
            NameSubCategory.placeholder = "Ingrese el nombre de la subcategoria"
            return
        }

        let image = imageIsNullOrNot(imageName: ImageSubCategory.image ?? UIImage())
        if image{
            
            let imageString = convertImageToBase64String(img: ImageSubCategory.image!)
            
            subCategoryModel = SubCategory(Id: 0,
                                           Nombre: nombre,
                                           Imagen: imageString,
                                           IdCategory: id)
            let result = subCategoryViewModel.Add(subCategorie: subCategoryModel!)
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Subcategoría agregada", preferredStyle: .alert)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    self.NameSubCategory.text = ""
                    self.ImageSubCategory = UIImageView(image: UIImage(systemName: "photo.circle.fill"))
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(Aceptar)
                self.present(alert,animated: false)
            }else{
                let alert = UIAlertController(title: "Confirmación", message: "Subcategoría no agregada", preferredStyle: .alert)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in

                })
                alert.addAction(Aceptar)
                self.present(alert,animated: false)
            }
            
        }else{
            let alert = UIAlertController(title: "Confirmación", message: "Subcategoría no agregada", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in

            })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }

}



extension SubcategoryNewVC : UIImagePickerControllerDelegate {
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
        self.ImageSubCategory.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
