
import UIKit
import SnapKit
import MediaPlayer

class ListMusicViewController: UIViewController {
    
    let listMusicViewModel = ListMusicViewModel()
    
    let listMusicTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraintsTableView()
        setupTableView()
        listMusicViewModel.loadListMusics()
    }
    

    private func setupConstraintsTableView() {
        view.addSubview(listMusicTableView)
        
        listMusicTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
