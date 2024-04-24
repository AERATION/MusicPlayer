
import Foundation
import UIKit

extension ListMusicViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        listMusicTableView.dataSource = self
        listMusicTableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        listMusicTableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listMusicViewModel.tracks.count
        return MusicService.shared.newTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackCell = listMusicTableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell else {
            return UITableViewCell()
        }
//        trackCell.configureCell(track: listMusicViewModel.tracks[indexPath.row])
        trackCell.configureCell(track: MusicService.shared.newTracks[indexPath.row])
        return trackCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cellViewModel = listMusicViewModel.tracks[indexPath.row]
        let cellViewModel = MusicService.shared.newTracks[indexPath.row]
        let playerDetailVC = PlayerDetailViewController()
        playerDetailVC.detailVM.startPlayback(trackIndex: indexPath.row)
        self.present(playerDetailVC, animated: true)
    }
}
