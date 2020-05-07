//
//  ViewController.swift
//  Encryption
//
//  Created by Lainey Neild on 3/18/20.
//  Copyright © 2020 Elaine Neild. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var messageTextBox: UITextField!
    
    @IBOutlet weak var keyWordTextBox: UITextField!
    
    @IBOutlet weak var newMessageText: UILabel!
    
    
    //all possible chars typed
    var alphebet: [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",".","?","!",",","1","2","3","4","5","6","7","8","9","0","@","#","$","%","^","&","*","(",")","-","=","+","/","|","{","}",";",":","]","[","'","`","~","\""," "]
    
   //startup method - ensure everything is running
   override func viewDidLoad() {
       super.viewDidLoad()
    
        newMessageText.layer.borderWidth = 1.0
        newMessageText.layer.borderColor = UIColor.lightGray.cgColor
    
   }
    
    private func textToNumArr (str: String) -> [Int] {
        //arr of index values
        let length: Int = str.count
        let charArr = Array(str)
        var numArr: [Int] = [Int](repeating: 0, count:length)
        
        
        //set each value in the array to the index of each char in the string
        for i in 0...(length-1) {
            let c: Character = charArr[i]
            var index: Int
            if (alphebet.contains(c)){
                index = alphebet.firstIndex(of: c)!
            }
            else {
                index = alphebet.firstIndex(of: "?")!
            }
            
            numArr[i] = index
        }
        
        return numArr
    }
    
    private func encryptNumArr (mess: [Int], key: [Int] ) -> [Int]{
        //new array of ints (size = mess.length)
        //encryptNum = (mess[i] + key[i % key.length]) % alphebet.length+1
        let length = mess.count
        var encryptNum: [Int] = [Int](repeating: 0, count:length)
        for i in 0...(mess.count-1){
            encryptNum[i] = (mess[i] + key [i % key.count] ) % (alphebet.count)
        }
        
        return encryptNum

    }
    
    func numToString(encryptNum: [Int]) -> String {
        //get values from alphebet arr
        //display in the message text box
	// more comments the better        
        var encryptText: String = ""
        
        for i in 0...(encryptNum.count-1) {
            let index: Int = encryptNum[i]
            let c: Character = alphebet[index]
            encryptText.append(c)
        }
        
        return encryptText
    
    }
    
    private func decryptNumArr (mess: [Int], key: [Int]) -> [Int] {
        //new array of ints (size = mess.length)
        //decryptedNum = (mess[i] - key[i % key.length]) % alphebet.length+1
        
        let length = mess.count
        var num = 0;
        var decryptNum: [Int] = [Int](repeating: 0, count:length)
            for i in 0...(mess.count-1){
                num = mess[i] - key [i % key.count]
                if (num < 0){
                    num = alphebet.count + num
                }
                decryptNum[i] = num
            }
               
            return decryptNum
    }

    @IBAction func encrypt(_ sender: Any) {
        var txt: String = messageTextBox.text!
        txt = txt.lowercased()
        var code: String = keyWordTextBox.text!
        code = code.lowercased()
        
        let txtNumArr: [Int] = textToNumArr(str: txt)
        let codeNumArr: [Int] = textToNumArr(str: code)
        
        let encNumArr: [Int] = encryptNumArr(mess: txtNumArr, key: codeNumArr)
        
        let encMessage: String = numToString(encryptNum: encNumArr)
        
        newMessageText.text! = encMessage
        
    }
    
    
    @IBAction func decrypt(_ sender: Any) {
        var txt: String = messageTextBox.text!
        txt = txt.lowercased()
        var code: String = keyWordTextBox.text!
        code = code.lowercased()
        
        let txtNumArr: [Int] = textToNumArr(str: txt)
        let codeNumArr: [Int] = textToNumArr(str: code)
        
        let decNumArr: [Int] = decryptNumArr(mess: txtNumArr, key: codeNumArr)
        
        let decMessage: String = numToString(encryptNum: decNumArr)
        
        newMessageText.text! = decMessage
        
    }
    
    @IBAction func copyMessage(_ sender: Any) {
        let newMessage: String = newMessageText.text!
        
        messageTextBox.text = newMessage
        
    }
    
    
    
}

