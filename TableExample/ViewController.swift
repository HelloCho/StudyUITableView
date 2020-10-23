import UIKit

class ViewController: UIViewController {

    var list = Sample.sampleList
    private var isTableEditing = false
    
    // 화면 동작 -> 0: 셀 수정, 삭제, 1: 셀 추가
    var howIsWorking = 0
    
    @IBOutlet weak var sampleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tableViewListCount = self.sampleTable.numberOfRows(inSection: 0)
        // update 일 경우 테이블 추가 X
        if tableViewListCount != list.count {
            // print("Get last sample : \(list.last!)")
            let lastIndex = IndexPath(row: list.count-1, section: 0)
            // sampleTable.reloadData() : 성능저하 원인 insertRows로 대체
            sampleTable.insertRows(at: [lastIndex], with: .bottom)
        } else {
            sampleTable.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 포커스가 제일 아래로 향하게 만들기
        if howIsWorking == 1 {
            let lastIndex = IndexPath(row: list.count-1, section: 0)
            sampleTable.scrollToRow(at: lastIndex, at: .bottom, animated: true)
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
        
        if let url = sample.imgUrl {
            do {
//                let path = try String(contentsOfFile: url.path) // 리뷰 : 이부분에서 오류가 나서 catch로 넘어갑니다. 주석처리해서 하면 잘 작동하네요.
                let data = try Data(contentsOf: url)
                pastaImage.image = UIImage(data: data)
            } catch {
                print("Error Message : \(error)")
            }
        } else {
            pastaImage.image = sample.senderImage
        }
    }
}
