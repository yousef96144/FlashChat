//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController  {
   
    

    var messagesarray=[Message]()
    
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate=self
        tableview.dataSource=self
        
         title = K.appname
        
        navigationItem.hidesBackButton = true
        
        
        loaddata()
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let email = Auth.auth().currentUser?.email , let messagebody = messageTextfield.text{
//            let message = Message(sender: Auth.auth().currentUser?.email, body: messageTextfield.text!)
            
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : email ,
                K.FStore.bodyField: messagebody ,
                K.FStore.dateField:Date().timeIntervalSince1970 ]){
                (error) in
                if let e = error{
                    print("faild to save data\(e)")
                }else{
                    print("succeed to save data")
                    self.loaddata()
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text=""
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func logoutpressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! cellformessage
        let message = messagesarray[indexPath.row]
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email{
            cell.lefimageview.isHidden = true
            cell.avatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            
        }else{
            cell.lefimageview.isHidden = false
            cell.avatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
}


extension ChatViewController{
    
    func loaddata(){
        db.collection(K.FStore.collectionName)
        .order(by:K.FStore.dateField)
        .addSnapshotListener { (querySnapshot, error) in
            self.messagesarray = []

            if let e = error{
                print("faild retreive data\(e)")
            }else{
                if let snapshotdocument = querySnapshot?.documents{
                    for doc in  snapshotdocument{
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String , let body = data[K.FStore.bodyField] as? String{
                            let newmessage = Message(sender: sender, body: body)
                            self.messagesarray.append(newmessage)
                            
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                                let indexpath = IndexPath(row: self.messagesarray.count-1, section: 0)
                                self.tableview.scrollToRow(at: indexpath, at: .top, animated: true)

                            }
                        }
                        
                                
                    }
                }

            }
        }
    }
}

extension ChatViewController{
    func callnibcell(){
        tableview.register( UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

    }
}
