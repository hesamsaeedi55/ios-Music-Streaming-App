//
//  protocols.swift
//  Javan Records
//
//  Created by Hesamoddin on 12/6/19.
//  Copyright © 2019 Hesamoddin. All rights reserved.
//

import Foundation

protocol userCellDelegate {
 func followTappedButton(for cell:searchcell)
}

protocol goto {
    func addButtonTapped(for cell: tracksTableViewCell)
}
protocol goto2 {
    func addButtonTapped(for cell: plsTrackCellTableViewCell)
}

protocol done {
   func downloadCompleted(for cell : tracksTableViewCell)
}

protocol done2 {
   func downloadCompleted(for cell : plsTrackCellTableViewCell)
}
protocol what {
    func playButtonTapped(for cell : tracksTableViewCell)
}
protocol dones {
    func downloadCompleted(for cell : plsTrackCellTableViewCell)
}
protocol what2 {
   func playButtonTapped(for cell : plsTrackCellTableViewCell)
}
protocol alert {
    func linkpopup(for cell: profileHeader)
}
