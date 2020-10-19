//
//  ItemViewController.swift
//  TableExample
//
//  Created by 조경식 on 2020/10/19.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Shadow Effect : UITextField
        //Basic texfield Setup
        titleTextField.borderStyle = .none
        titleTextField.backgroundColor = .white

        //To apply corner radius
        titleTextField.layer.cornerRadius = titleTextField.frame.size.height / 5

        //To apply border
        titleTextField.layer.borderWidth = 0.25
        titleTextField.layer.borderColor = UIColor.white.cgColor

        //To apply Shadow
        titleTextField.layer.shadowOpacity = 0.5
        titleTextField.layer.shadowRadius = 2.0
        titleTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
        titleTextField.layer.shadowColor = UIColor.gray.cgColor

        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: titleTextField.frame.height))
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = UITextField.ViewMode.always
        
        
        // Shadow Effect : UITextView
        descriptionTextView.layer.cornerRadius = descriptionTextView.frame.size.height/50
        descriptionTextView.clipsToBounds = false
        descriptionTextView.layer.shadowOpacity = 0.4
        descriptionTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        // Shadow Effect : UIView+UIImageView
        imgView.applyshadowWithCorner(containerView: containerView, cornerRadious: 3.0)
        
        // Button Effect
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.borderColor = UIColor.systemPink.cgColor
        cancelButton.layer.cornerRadius = 3
        
        createdButton.layer.borderWidth = 3
        createdButton.layer.borderColor = UIColor.systemGreen.cgColor
        createdButton.layer.cornerRadius = 3
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? ViewController
            let tempSample = Sample(name: titleTextField.text ?? "Hi", description: descriptionTextView.text ?? "Hello, World~!", imageName: "pasta1")
            vc?.list.append(tempSample)
            let lastIndexPath = IndexPath(row: (vc?.list.count ?? 0) - 1, section: 0)
            vc?.sampleTable.insertRows(at: [lastIndexPath], with: .bottom)
            vc?.sampleTable.reloadData()
        }
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createdAction(_ sender: UIButton) {
        // https://yzzzzun.tistory.com/27 참조 Segue간 데이터 이동 이해 부족
    }
    
}

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize.zero
//        containerView.layer.shadowRadius = 20
        containerView.layer.cornerRadius = cornerRadious
//        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
