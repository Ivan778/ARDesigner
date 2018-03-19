

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

class GoogleDriveViewController: DownloadViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    let service = GTLRDriveService()
    var pathID = [String]()
    var pathName = [String]()
    
    // MARK: - SignIn delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            notAuthorized(visible: false)
            getFilesList(folderID: "root", folderName: "Root", refresh: false)
        }
    }
    
    // MARK: - overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDriveReadonly]

        initView(name: "Google Drive", image: #imageLiteral(resourceName: "GoogleDrive"))
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent(notification:)), name: refresh, object: nil)

        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            if !refreshControl.isRefreshing {
                self.startIndicator()
            }
            GIDSignIn.sharedInstance().signIn()
        }
        updateButtons()
    }
    
    // MARK: - SignIn button
    override func signInPressed() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signOut()
            let alert = UIAlertController(title: "Account Unlinked!", message: "Your Google Drive account has been unlinked", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            listToDownload.removeAll()
            content[0].removeAll()
            content[1].removeAll()
            pathID.removeAll()
            pathName.removeAll()
            filesTableView.reloadData()
            lastFolder = ""
            self.updateButtons()
            notAuthorized(visible: true)
        } else {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if content[indexPath.section][indexPath.row].isFile() {
            content[indexPath.section][indexPath.row].setMarked(value: content[indexPath.section][indexPath.row].marked ? false : true)

            if content[indexPath.section][indexPath.row].marked {
                listToDownload.append(content[indexPath.section][indexPath.row])
            } else {
                listToDownload = listToDownload.filter({ $0.id != content[indexPath.section][indexPath.row].id })
            }

            filesTableView.deselectRow(at: indexPath, animated: false)
            filesTableView.reloadData()
        } else {
            getFilesList(folderID: content[indexPath.section][indexPath.row].id, folderName: content[indexPath.section][indexPath.row].name, refresh: false)
            filesTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    // MARK: - refreshing
    override func refreshPressed() {
        NotificationCenter.default.post(name: refresh, object: nil)
    }
    
    // MARK: - save buttons
    override func saveAllPressed() {
        if !content[1].isEmpty {
            startIndicator()

            if !listToDownload.isEmpty {
                listToDownload.removeAll()
            }
            for downloadFile in content[1] {
                downloadGroup.enter()
                download(currentFile: downloadFile)
            }

            downloadGroup.notify(queue: .main) {
                self.stopIndicator()
            }

            self.filesTableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Nothing Download", message: "There is no files to download", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.stopIndicator()
        }
    }
    
    override func saveSelectedPressed() {
        if !listToDownload.isEmpty {
            startIndicator()
            for downloadFile in listToDownload {
                downloadGroup.enter()
                download(currentFile: downloadFile)
            }

            downloadGroup.notify(queue: .main) {
                self.stopIndicator()
            }

            listToDownload.removeAll()
            self.filesTableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Nothing Selected", message: "Select files which you want download", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - download file
    func download(currentFile: GDMaybeDBFile) {
        var isZip = false
        if ("zip".caseInsensitiveCompare(DownloadViewController.fileExtension(file: currentFile.name)) == ComparisonResult.orderedSame) {
            isZip = true
        }

        let manager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destUrl = manager.appendingPathComponent("models/\(currentFile.name)")
        
        let query = GTLRDriveQuery_FilesGet.queryForMedia(withFileId: currentFile.id)
        service.executeQuery(query, completionHandler: { ticket, result, error in
            self.downloadGroup.leave()
            if error != nil {
                print("Error downloading file!")
                return
            }
            let object = result as! GTLRDataObject
            do {
                try object.data.write(to: destUrl.deletingPathExtension().appendingPathExtension("zip"))
                DownloadViewController.extractARD(destURL: destUrl.deletingPathExtension().appendingPathExtension("zip"))
            }
            catch {
                print("Something going wrong while saving file!")
            }
            if isZip {
                print(DownloadViewController.checkZip(destURL: destUrl))
            }
        })
    }
    
    func updateButtons() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            notAuthorized(visible: false)
        } else {
            notAuthorized(visible: true)
        }
        
        self.view.reloadInputViews()
    }
    
    // MARK: - get list of files in folder
    func getFilesList(folderID: String, folderName: String, refresh: Bool) {
        if !refreshControl.isRefreshing {
            self.startIndicator()
        }
        
        let query = GTLRDriveQuery_FilesList.query()
        query.q = "'\(folderID)' in parents and trashed=false"
        service.executeQuery(query, completionHandler: { ticket, result, error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            if !refresh {
                if folderName.contains("⬅ ") {
                    self.pathID.removeLast()
                    self.pathName.removeLast()
                } else {
                    self.pathID.append(folderID)
                    self.pathName.append(folderName)
                }
            }
            
            self.content[0].removeAll()
            self.content[1].removeAll()
            
            if let files = (result as! GTLRDrive_FileList).files, !files.isEmpty {
                for file in files {
                    self.downFile = GDMaybeDBFile(tag: file.mimeType!, id: file.identifier!, name: file.name!, path_display: "", path_lower: "", marked: false)
                    if self.downFile.tag == "application/vnd.google-apps.folder" {
                        self.content[0].append(self.downFile)
                    } else {
                        if !("ard".caseInsensitiveCompare(DownloadViewController.fileExtension(file: self.downFile.name)) == ComparisonResult.orderedSame) {
                            continue
                        }
                        self.downFile.tag = "file"
                        self.downFile.marked = true
                        self.content[1].append(self.downFile)
                    }
                    
                }
            }
            
            if folderID != "root" {
                self.downFile = GDMaybeDBFile(tag: "folder", id: self.pathID[self.pathID.count - 2], name: "⬅ \(self.pathName[self.pathName.count - 2])", path_display: "", path_lower: "", marked: false)
                self.content[0].insert(self.downFile, at: 0)
            }
            
            print(self.pathID)
            
            DispatchQueue.main.async {
                self.filesTableView.reloadData()
                self.refreshControl.endRefreshing()
                self.stopIndicator()
            }
        })
    }
    
    // MARK: - Google Drive functions
    @objc func refreshContent(notification: Notification) {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            if pathID.count == 0 {
                getFilesList(folderID: "root", folderName: "Root", refresh: true)
            } else {
                getFilesList(folderID: pathID[pathID.count - 1], folderName: pathName[pathName.count - 1], refresh: true)
            }
            
            self.updateButtons()
        } else {
            refreshControl.endRefreshing()
            notAuthorized(visible: true)
        }
    }
    
    // MARK: - Alerts
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
