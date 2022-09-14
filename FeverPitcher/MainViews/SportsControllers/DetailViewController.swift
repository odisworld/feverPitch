//
//  EventDetailsViewController.swift
//  FeverPitcher
//
//  Created by Consultant on 27/08/2022.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var wvMain: WKWebView!
    
    //5-2
    var url : String? = ""
    var titletext : String? = ""
    var locationtext : String? = ""
    var datetext : String? = ""
    var eventTitle: String = ""
    var eventImage: UIImage = UIImage(named: "testImage")!
    var eventDate: String = ""
    var eventTime: String = ""
    var eventLocation: String = ""
    var isFavorited: Bool = false
    var id: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titletext

        let urlAddress = URL(string: url!)
        let request = URLRequest(url: urlAddress!)
        wvMain.load(request)
        
    }
 

}

