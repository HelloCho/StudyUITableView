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
        print(list.last)
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
    
}

class TableCell: UITableViewCell {
    
    @IBOutlet weak var pastaImage: UIImageView!
    @IBOutlet weak var pastaName: UILabel!
    @IBOutlet weak var pastaDescription: UILabel!
    
    func configure(sample: Sample) {
        pastaName.text = sample.name
        pastaDescription.text = sample.description
        pastaImage.image = UIImage(named: "\(sample.imageName).jpg")
    }
}