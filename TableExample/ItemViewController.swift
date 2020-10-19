import UIKit
import PhotosUI

class ItemViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createdButton: UIButton!
    
    // Image 내 사진 업로드
    @IBOutlet weak var photoUpload: UIButton!
    
    // https://zeddios.tistory.com/1052 참조 : iOS14 앞으로 UIPickerViewControler 에서 지금 PHPicker로 대체사용해야함.
    var configurationPhoto = PHPickerConfiguration()
    
    var sampleDetailInfo: Sample?
    
    // 메인 화면에서 셀을 클릭했을때 넘어온 인덱스 번호
    var selectedTableRowCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effectShadowTextField()
        effectShadowTextView()
        effectShadowImgview()
        effectStyleBoardButton()
        
        initPHPicker()
    }
    
    private func initPHPicker() {
        // 원하는 사진만 필터 : .images, .livePhotos, .videos
        configurationPhoto.filter = .any(of: [.images])
        // 사진선택 개수
        // configurationPhoto.selectionLimit = 2
    }
    
    // prepare로 데이터 전송시 viewDidLoad에서 구현 X, viewWillAppear 로 구현해야 데이터가 들어옴 ( Lifecycle 참조 )
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sampleDetailInfo != nil {
            titleTextField.text = sampleDetailInfo?.name
            descriptionTextView.text = sampleDetailInfo?.description
            
            var tempImg: UIImage?
            if sampleDetailInfo!.imageName != "none" {
                tempImg = sampleDetailInfo?.senderImage
            } else {
                tempImg = UIImage(data: sampleDetailInfo!.imgData!)
            }
            
            // imgView.image? = (tempImg?.rotate(radians: .pi/2)!)!
            imgView.image? = tempImg!
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
    
    // 사진 업로드 선택 시
    @IBAction func selectedPhoto(_ sender: UIButton) {
        let picker = PHPickerViewController(configuration: configurationPhoto)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    // 취소 시 전 화면으로 전환
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // 이전 화면으로 전환 : 데이터 생성 및 수정
    @IBAction func createdAction(_ sender: UIButton) {
        // 이전 화면 불러오기
        let preVC = self.presentingViewController
        // 이전화면의 뷰컨트롤러 변환
        guard let vc = preVC as? ViewController else { return }

        // 값을 전달한다.
        // Update / Insert 이슈 수정
        if let index = selectedTableRowCellIndex {
            let tempSample = Sample(name: titleTextField.text ?? "", description: descriptionTextView.text ?? "", imageName: "none", imgData: self.imgView.image?.pngData())
            vc.list.remove(at: index)
            vc.list.insert(tempSample, at: index)
        } else {
            let tempSample = Sample(name: titleTextField.text ?? "", description: descriptionTextView.text ?? "", imageName: "none", imgData: self.imgView.image?.pngData())
            vc.list.append(tempSample)
        }

        // 이전 화면으로 복귀한다.
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

// https://stackoverflow.com/questions/41475501/creating-a-shadow-for-a-uiimageview-that-has-rounded-corners 참조 UIImageView-UIView Shadow효과 주기
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

// 사진업로드
extension ItemViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 선택 후 먼저 picker를 dismiss시켜줍니다.
        picker.dismiss(animated: true, completion: nil)
        guard !results.isEmpty else { return }
        
        // itemProvider를 가져옵니다. itemProvider는 선택된 asset의 Representation이라고 해요.
        let itemProvider = results.first?.itemProvider
        
        // provider가 내가 지정한 타입을 로드할 수 있는지 먼저 체크를 한 뒤
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            // 로드 할 수 있으면 로드를 합니다.
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                // loadObject는 completionHandler로 NSItemProviderReading과 error를 줍니다
                DispatchQueue.main.async {
                    self.imgView.image = image as? UIImage
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
