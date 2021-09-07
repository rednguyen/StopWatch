//
//  ViewController.swift
//  StopWatch
//
//  Created by Red Nguyen on 8/29/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    var tableViewCellCount = 0
    let cellReuseIdentifier = "cell"
    let customTableViewCell = "CustomTableViewCell"
    var timeLap : [String] = []
    var lapCount : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        lapButton.isEnabled = false
        startButton.isEnabled = true
        
        timerLabel.layer.cornerRadius = 5.0
        timerLabel.layer.masksToBounds = true
        
        resetButton.layer.cornerRadius = 4.0
        resetButton.layer.masksToBounds = true
        resetButton.alpha = 0.5
        
        lapButton.layer.cornerRadius = 4.0
        lapButton.layer.masksToBounds = true
        lapButton.alpha = 0.5
        
        startButton.layer.cornerRadius = startButton.bounds.width / 2.0
        startButton.layer.masksToBounds = true
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.width / 2.0
        pauseButton.layer.masksToBounds = true
        pauseButton.isEnabled = false
        pauseButton.alpha = 0.5
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.register(UINib(nibName: customTableViewCell, bundle: nil), forCellReuseIdentifier: customTableViewCell)
        
    }
    
    @IBAction func resetDidTap(_ sender: Any) {
        timer.invalidate()
        isTimerRunning = false
        counter = 0.0
        
        timerLabel.text = "00:00:00.0"
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        lapButton.isEnabled = false
        
        resetButton.alpha = 0.5
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
        lapButton.alpha = 0.5
        
        timeLap = []
        self.tableView.reloadData()
    }
    
    
    @IBAction func pauseDidTap(_ sender: Any) {
        resetButton.isEnabled = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        lapButton.isEnabled = false
        
        resetButton.alpha = 1.0
        startButton.alpha = 1.0
        pauseButton.alpha = 0.5
        lapButton.alpha = 0.5
        
        isTimerRunning = false
        timer.invalidate()
    }
    
    
    @IBAction func startDidTap(_ sender: Any) {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            
            resetButton.isEnabled = true
            pauseButton.isEnabled = true
            startButton.isEnabled = false
            lapButton.isEnabled = true
            
            resetButton.alpha = 1.0
            startButton.alpha = 0.5
            pauseButton.alpha = 1.0
            lapButton.alpha = 1.0
        }
    }
    
    @IBAction func lapDidTap(_ sender: Any) {
        timeLap.append(timerLabel.text ?? "00:00:00.0")
        lapCount.append("Lap " + String(timeLap.count))
        
        resetButton.isEnabled = true
        pauseButton.isEnabled = true
        startButton.isEnabled = false
        lapButton.isEnabled = true
        
        resetButton.alpha = 1.0
        startButton.alpha = 0.5
        pauseButton.alpha = 1.0
        lapButton.alpha = 1.0
        
        self.tableView.reloadData()
    }
    
    
    // MARk: -Helper methods
    
    @objc func runTimer() {
        counter += 0.1
        // HH:MM:SS:_
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter / 3600
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerLabel.text = "\(hour):\(minuteString):\(secondString).\(decisecond)"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeLap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: customTableViewCell) as? CustomTableViewCell
        let label1 = cell?.contentView.viewWithTag(101) as? UILabel
        let label2 = cell?.contentView.viewWithTag(102) as? UILabel
        label1?.text = timeLap[indexPath.row]
        label2?.text = lapCount[indexPath.row]
        return cell ?? CustomTableViewCell()
    }
    
}

