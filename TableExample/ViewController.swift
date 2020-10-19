import UIKit

class ViewController: UIViewController {

    var list = Sample.sampleList
    private var isTableEditing = false
    
    @IBOutlet weak var sampleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let tableViewListCount = self.sampleTable.numberOfRows(inSection: 0)
        // update 일 경우 테이블 추가 X
        if tableViewListCount != list.count {
            // print("Get last sample : \(list.last!)")
            let lastIndex = IndexPath(row: list.count-1, section: 0)
            // sampleTable.reloadData() : 성능저하 원인 밑에 insertRows로 대체
            sampleTable.insertRows(at: [lastIndex], with: .bottom)
            sampleTable.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        } else {
            sampleTable.reloadData()
        }
        
    }
    @IBAction func tableSetting(_ sender: UIButton) {
        self.sampleTable.isEditing.toggle()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pastaCell", for: indexPath) as? TableCell else {return UITableViewCell()}
        cell.configure(sample: list[indexPath.row])
        return cell
    }
    
    /*
     선택한 로우 삭제
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /*
     Row(Cell)를 움직일 수 있게 만들어줌
      - tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
        : 기본 true ! false 일때, 안 움직임
      - tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
        : 선택한 로우(Cell)을 변경하고자하는 위치로 이동
     */
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(itemToMove, at: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDelegate {
    // 상세화면 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
    
    // 상세화면 데이터 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let itemVC = segue.destination as? ItemViewController {
                guard let index = sender as? Int else { return }
                itemVC.sampleDetailInfo = list[index]
                itemVC.selectedTableRowCellIndex = index
            }
        } else if segue.identifier == "showAdd" {
            
        }
    }
    
}

class TableCell: UITableViewCell {
    
    @IBOutlet weak var pastaImage: UIImageView!
    @IBOutlet weak var pastaName: UILabel!
    @IBOutlet weak var pastaDescription: UILabel!
    
    func configure(sample: Sample) {
        pastaName.text = sample.name
        pastaDescription.text = sample.description
        var tempImg: UIImage?
        if sample.imageName != "none" {
            tempImg = UIImage(named: "\(sample.imageName).jpg")
        } else {
            tempImg = UIImage(data: sample.imgData!)
        }
        
        // pastaImage.image? = (tempImg?.rotate(radians: .pi/2)!)!
        pastaImage.image? = tempImg!
    }
}

// https://stackoverflow.com/questions/27092354/rotating-uiimage-in-swift 참조 : 사진 업로드 후 메인화면에서 -90도로 보임 그래서 사용
extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
