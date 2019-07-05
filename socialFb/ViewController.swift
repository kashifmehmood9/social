//
//  ViewController.swift
//  social
//
//  Created by Kashif Mehmood on 17/09/2018.
//  Copyright © 2018 Kashif. All rights reserved.
//

import UIKit
import Social
import MediaPlayer

protocol aProtocol
{
    func aFunction()
}
class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,URLSessionDataDelegate,XMLParserDelegate {
    @IBOutlet weak var table: UITableView!
    var songs = NSArray()
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let parser = XMLParser(data:data )
        parser.delegate = self
        parser.parse()
        
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print(string)
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        
    }
    func loadData()
    
    {
        let is_URL: String = "http://www.cgsapi.com/CGSWebService.asmx"
        
        var lobj_Request = URLRequest(url: URL(string: is_URL)!)
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: OperationQueue.current)
        
      
        let is_SoapMessage: String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cgs=\"http://www.cgsapi.com/\"><soapenv:Header/><soapenv:Body><cgs:GetSystemStatus/></soapenv:Body></soapenv:Envelope>"

        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        
        lobj_Request.addValue("www.cgsapi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://www.GBSapi.com/GetSystemStatus", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request)
        task.resume()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
       // perform(#selector(openGallery), with: nil, afterDelay: 2)
        
//        let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=abba"
//        let url = URL(string: urlString)
//
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//
//          //  let http = response as? HTTPURLResponse
//
//            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
//            let arr = json!["results"] as! NSArray
//            self.songs = arr
//
//            DispatchQueue.main.async {
//            self.table.reloadData()
//            }
//
//
//
//        }).resume()
 
        //playSound(soundUrl: "https://www.myinstants.com/media/sounds/cade-o-respeito.mp3")
    }
    func playSound(soundUrl: String) {
        let _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        let _ = try? AVAudioSession.sharedInstance().setActive(true)
        
        let sound = URL(fileURLWithPath: soundUrl)
        do {
            
            let playerItem = AVPlayerItem(url: sound)
            playerItem.preferredForwardBufferDuration = TimeInterval(0)
            let audioPlayer =  AVPlayer(playerItem: playerItem)
            audioPlayer.automaticallyWaitsToMinimizeStalling = true
            audioPlayer.play()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let resp = songs[indexPath.row] as! [String:Any]
        let cell = table.dequeueReusableCell(withIdentifier: "Cell")
        
        let labelArtist = cell?.contentView.viewWithTag(2) as! UILabel
        let labelCollectionName = cell?.contentView.viewWithTag(3) as! UILabel
        let labelPrice = cell?.contentView.viewWithTag(4) as! UILabel
        let labelTrackName = cell?.contentView.viewWithTag(5) as! UILabel
        
        labelArtist.text = resp["artistName"] as? String
        labelPrice.text = String(format: "%f", (resp["collectionPrice"] as? Double)!)
        labelCollectionName.text = resp["collectionName"] as? String
        labelTrackName.text = resp["trackName"] as? String
        
        let imageView = cell?.contentView.viewWithTag(1) as! UIImageView
        
        
        let url = URL(string: resp["artworkUrl100"] as! String)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
            
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

