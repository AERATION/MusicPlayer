
import Foundation
import UIKit

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListMusicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        listMusicTableView.dataSource = self
        listMusicTableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        listMusicTableView.register(UINib(nibName: String(describing: MusicViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MusicViewCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMusicViewModel.getListMusicsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackCell = listMusicTableView.dequeueReusableCell(withIdentifier: MusicViewCell.identifier, for: indexPath) as? MusicViewCell else {
            return UITableViewCell()
        }
        let trackList = listMusicViewModel.getTracks()
        trackCell.configureCell(track: trackList[indexPath.row])
        return trackCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerDetailVC = PlayerDetailViewController()
        playerDetailVC.detailViewModel.onMusicCellTapped(trackIndex: indexPath.row)
        self.present(playerDetailVC, animated: true)
    }
}
