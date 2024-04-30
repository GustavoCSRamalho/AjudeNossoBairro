//
//  MovieFormViewController.swift
//  MoviesLib
//
//  Created by Gustavo Ramalho on 24/04/24.
//

import UIKit

class NewsFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldReport: UITextView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var news: News?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let news = news {
            title = "Edicao"
            textFieldName.text = news.name
            textFieldAddress.text = news.address
            textFieldReport.text = news.report
            if let movie = news.image {
                imageViewPoster.image = UIImage(data: movie)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal )
        }
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
//
//        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
//        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
//    }
//
//    @objc func keyboardWillHide() {
//
//    }
    
    @IBAction func selectPoster(_ sender: Any) {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde voce deseja escolher o poster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)

        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Album de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)

        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
        if news == nil {
            news = News(context: context)
        }
        news?.name = textFieldName.text
        news?.address = textFieldAddress.text
        news?.report = textFieldReport.text
        news?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
        
    }
}

extension NewsFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
