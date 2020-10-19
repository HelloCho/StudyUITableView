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
    
    var sampleDetailInfo: Sample?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effectShadowTextField()
        effectShadowTextView()
        effectShadowImgview()
        effectStyleBoardButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sampleDetailInfo != nil {
            titleTextField.text = sampleDetailInfo?.name
            descriptionTextView.text = sampleDetailInfo?.description
            imgView.image = sampleDetailInfo?.senderImage
            
            createdButton.setTitle("수정", for: .normal)
        }
    }
    
    // Shadow Effect : UITextField
    private func effectShadowTextField() {
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
    }
    
    // Shadow Effect : UITextView
    private func effectShadowTextView() {
        descriptionTextView.layer.cornerRadius = descriptionTextView.frame.size.height/50
        descriptionTextView.clipsToBounds = false
        descriptionTextView.layer.shadowOpacity = 0.4
        descriptionTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // Shadow Effect : UIView+UIImageView
    private func effectShadowImgview() {
        imgView.applyshadowWithCorner(containerView: containerView, cornerRadious: 3.0)
    }
    
    private func effectStyleBoardButton() {
        // Button Effect
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.borderColor = UIColor.systemPink.cgColor
        cancelButton.layer.cornerRadius = 3
        
        createdButton.layer.borderWidth = 3
        createdButton.layer.borderColor = UIColor.systemGreen.cgColor
        createdButton.layer.cornerRadius = 3
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createdAction(_ sender: UIButton) {
        // 이전 화면 불러오기
        let preVC = self.presentingViewController
        // 이전화면의 뷰컨트롤러 변환
        guard let vc = preVC as? ViewController else { return }

        // 값을 전달한다.
        let tempSample = Sample(name: titleTextField.text ?? "Hi", description: descriptionTextView.text ?? "Hello, World~!", imageName: "pasta1")
        vc.list.append(tempSample)

        // 이전 화면으로 복귀한다.
        self.presentingViewController?.dismiss(animated: true)
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

extension ItemViewController: UITextFieldDelegate {
    // done key 입력 시 키보드 내려가기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

