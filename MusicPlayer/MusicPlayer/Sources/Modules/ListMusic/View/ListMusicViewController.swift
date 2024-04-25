
import UIKit
import SnapKit
import MediaPlayer

final class ListMusicViewController: UIViewController {
    
    //MARK: Properties
    let listMusicViewModel = ListMusicViewModel()
    
    let listMusicTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()
    
    //MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraintsTableView()
        setupTableView()
        listMusicViewModel.loadListMusics()
    }
    
    //MARK: private methods
    private func setupConstraintsTableView() {
        view.addSubview(listMusicTableView)
        
        listMusicTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
