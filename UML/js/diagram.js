var entities =
[{
  "id": 1,
  "typeString": "enum",
  "cases": [
    {
  "name": "x case y case z case non case upDown"
}
  ],
  "name": "Axis"
},{
  "id": 2,
  "typeString": "class",
  "properties": [
    {
  "name": "var sceneView: ARSCNView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var selectModelButton: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var progressIndicator: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var activityIndicator: UIActivityIndicatorView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var openOnce",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var objectToManage",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var shouldMoveModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var shouldRotateOrResizeModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var axis",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var previousValue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tableView",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var arrayOfModels",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var prefersStatusBarHidden: Bool",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getModel()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addGesturesToSceneView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "rotateOrResizeModel(_ sender:UIPanGestureRecognizer)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "configureLighting()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "viewWillAppear(_ animated: Bool)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setUpSceneView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "viewWillDisappear(_ animated: Bool)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "selectModelClicked(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "downloadButtonPressed(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "googleDrivePressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "filesPressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "pressedRestartSessionButton(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ],
  "name": "MainViewController",
  "superClass": 22,
  "extensions": [
    3,
    4
  ]
},{
  "id": 6,
  "typeString": "class",
  "properties": [
    {
  "name": "var navBar: UINavigationBar!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var signInItem: UIBarButtonItem!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var signInButton: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var signInView: UIView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var refreshButton: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var refreshControl: UIRefreshControl!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var filesTableView: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var saveSelected: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var saveAll: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var closeButton: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var controlButtonsStackView: UIStackView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var indicator: UIActivityIndicatorView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var waitView: UIView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var backgroundIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downFile: GDMaybeDBFile!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var listToDownload: [GDMaybeDBFile]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var lastFolder",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var content: [[GDMaybeDBFile]]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var sections: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tag",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var id",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let downloadGroup",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let refresh",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "DownloadViewController",
  "superClass": 22,
  "extensions": [
    5
  ]
},{
  "id": 7,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var pathToFile: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var arrayWithURL",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var content",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentDirectory: String?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "pressedBack(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "AddModelViewController",
  "superClass": 22,
  "extensions": [
    8
  ]
},{
  "id": 9,
  "typeString": "protocol",
  "methods": [
    {
  "name": "googleDrivePressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "filesPressed()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SelectDownloadSourceDelegate"
},{
  "id": 10,
  "typeString": "class",
  "properties": [
    {
  "name": "var googleDrive: UIButton!",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files: UIButton!",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var view: UIView!",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var delegate: SelectDownloadSourceDelegate! convenience required @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "initializeView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setViewConstraints()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "setGoogleDriveButtonConstraints()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "setFilesButtonConstraints()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "createButton(title: String) -> UIButton",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "googleDrivePressed()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "filesPressed()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(frame: CGRect)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(coder aDecoder: NSCoder)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SelectDownloadSource",
  "superClass": 23
},{
  "id": 11,
  "typeString": "class",
  "properties": [
    {
  "name": "let service",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var pathID",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var pathName",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "signInPressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "refreshPressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveAllPressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveSelectedPressed()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "download(currentFile: GDMaybeDBFile)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateButtons()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getFilesList(folderID: String, folderName: String, refresh: Bool)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "refreshContent(notification: Notification)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showAlert(title : String, message: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "GoogleDriveViewController",
  "superClass": 6
},{
  "id": 12,
  "typeString": "class",
  "properties": [
    {
  "name": "var tag:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var id:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var name:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var path_display:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var path_lower:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var marked:Bool",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "isFile() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setMarked(value: Bool)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(tag: String, id: String, name: String, path_display: String, path_lower: String, marked: Bool)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "GDMaybeDBFile"
},{
  "id": 13,
  "typeString": "class",
  "methods": [
    {
  "name": "init(position: SCNVector3)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init?(coder aDecoder: NSCoder)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SphereNode",
  "superClass": 24
},{
  "id": 14,
  "typeString": "class",
  "methods": [
    {
  "name": "checkAvailabilityOftheFolder()",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "copyFiles(pathFromBundle: String, pathDestDocs: String)",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "copyDocuments()",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "DirectoryManager"
},{
  "id": 15,
  "typeString": "class",
  "properties": [
    {
  "name": "var window: UIWindow? @available(iOS 9.0, *)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationWillResignActive(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationDidEnterBackground(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationWillEnterForeground(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationDidBecomeActive(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationWillTerminate(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    26
  ],
  "name": "AppDelegate",
  "superClass": 25
},{
  "id": 16,
  "typeString": "class",
  "methods": [
    {
  "name": "virtualObject(at point: CGPoint, of sceneView: ARSCNView) -> [SCNHitTestResult]",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "parentNode(node: SCNNode) -> SCNNode",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "ModelManager"
},{
  "id": 17,
  "typeString": "struct",
  "properties": [
    {
  "name": "let filePathURL: URL",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let fileName: String?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "filePath() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ProcessedFilePath"
},{
  "id": 18,
  "typeString": "class",
  "properties": [
    {
  "name": "let includeRootDirectory",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let fileManager",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "processZipPaths(_ paths: [URL]) -> [ProcessedFilePath]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "expandDirectoryFilePath(_ directory: URL) -> [ProcessedFilePath]",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ZipUtilities",
  "containedEntities": [
    17
  ]
},{
  "id": 19,
  "typeString": "enum",
  "properties": [
    {
  "name": "var description: String",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "cases": [
    {
  "name": "fileNotFound case unzipFail case zipFail public var description"
}
  ],
  "name": "ZipError",
  "superClass": 27
},{
  "id": 20,
  "typeString": "enum",
  "properties": [
    {
  "name": "var minizipCompression: Int32",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "cases": [
    {
  "name": "NoCompression case BestSpeed case DefaultCompression case BestCompression internal var minizipCompression"
}
  ],
  "name": "ZipCompression",
  "superClass": 28
},{
  "id": 21,
  "typeString": "class",
  "properties": [
    {
  "name": "var customFileExtensions: Set<String>",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "unzipFile(_ zipFilePath: URL, destination: URL, overwrite: Bool, password: String?, progress: ((_ progress: Double) -> ())? = nil, fileOutputHandler: ((_ unzippedFile: URL) -> Void)? = nil) throws",
  "type": "type",
  "accessLevel": "public"
},
    {
  "name": "zipFiles(paths: [URL], zipFilePath: URL, password: String?, compression: ZipCompression = .DefaultCompression, progress: ((_ progress: Double) -> ())?) throws",
  "type": "type",
  "accessLevel": "public"
},
    {
  "name": "fileExtensionIsInvalid(_ fileExtension: String?) -> Bool",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "addCustomFileExtension(_ fileExtension: String)",
  "type": "type",
  "accessLevel": "public"
},
    {
  "name": "removeCustomFileExtension(_ fileExtension: String)",
  "type": "type",
  "accessLevel": "public"
},
    {
  "name": "isValidFileExtension(_ fileExtension: String) -> Bool",
  "type": "type",
  "accessLevel": "public"
},
    {
  "name": "init ()",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "name": "Zip"
},{
  "id": 22,
  "typeString": "class",
  "name": "UIViewController"
},{
  "id": 23,
  "typeString": "class",
  "name": "UIView"
},{
  "id": 24,
  "typeString": "class",
  "name": "SCNNode"
},{
  "id": 25,
  "typeString": "class",
  "name": "UIResponder"
},{
  "id": 26,
  "typeString": "protocol",
  "name": "UIApplicationDelegate"
},{
  "id": 27,
  "typeString": "class",
  "name": "Error"
},{
  "id": 28,
  "typeString": "class",
  "name": "Int"
},{
  "id": 29,
  "typeString": "protocol",
  "name": "ARSCNViewDelegate"
},{
  "id": 30,
  "typeString": "protocol",
  "name": "UITableViewDelegate"
},{
  "id": 31,
  "typeString": "protocol",
  "name": "UITableViewDataSource"
},{
  "id": 3,
  "typeString": "extension",
  "methods": [
    {
  "name": "renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    29
  ]
},{
  "id": 4,
  "typeString": "extension",
  "methods": [
    {
  "name": "setTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    30,
    31
  ]
},{
  "id": 5,
  "typeString": "extension",
  "methods": [
    {
  "name": "numberOfSections(in tableView: UITableView) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    31,
    30
  ]
},{
  "id": 8,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "isDir(atPath: String) -> Bool?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    31,
    30
  ]
}]
;

var renderedEntities = [];

var useCentralNode = true;

var templates = {
  case: undefined,
  property: undefined,
  method: undefined,
  entity: undefined,
  data: undefined,

  setup: function() {
    this.case = document.getElementById("case").innerHTML;
    this.property = document.getElementById("property").innerHTML;
    this.method = document.getElementById("method").innerHTML;
    this.entity = document.getElementById("entity").innerHTML;
    this.data = document.getElementById("data").innerHTML;

    Mustache.parse(this.case)
    Mustache.parse(this.property);
    Mustache.parse(this.method);
    Mustache.parse(this.entity);
    Mustache.parse(this.data);
  }
}

var colorSuperClass = { color: "#848484", highlight: "#848484", hover: "#848484" }
var colorProtocol = { color: "#9a2a9e", highlight: "#9a2a9e", hover: "#9a2a9e" }
var colorExtension = { color: "#2a8e9e", highlight: "#2a8e9e", hover: "#2a8e9e" }
var colorContainedIn = { color: "#99AB22", highlight: "#99AB22", hover: "#99AB22" }
var centralNodeColor = "rgba(0,0,0,0)";
var centralEdgeLengthMultiplier = 1;
var network = undefined;

function bindValues() {
    templates.setup();

    for (var i = 0; i < entities.length; i++) {
        var entity = entities[i];
        var entityToBind = {
            "name": entity.name == undefined ? entity.typeString : entity.name,
            "type": entity.typeString,
            "props": renderTemplate(templates.property, entity.properties),
            "methods": renderTemplate(templates.method, entity.methods),
            "cases": renderTemplate(templates.case, entity.cases)
        };
        var rendered = Mustache.render(templates.entity, entityToBind);
        var txt = rendered;
        document.getElementById("entities").innerHTML += rendered;
    }

    setSize();
    setTimeout(startCreatingDiagram, 100);
}

function renderTemplate(template, list) {
    if (list != undefined && list.length > 0) {
        var result = "";
        for (var i = 0; i < list.length; i++) {
            var temp = Mustache.render(template, list[i]);
            result += temp;
        }
        return result;
    }
    return undefined;
}

function getElementSizes() {
  var strings = [];
  var elements = $("img");

  for (var i = 0; i < elements.length; i++) {
      var element = elements[i];
      
      var elementData = {
        width: element.offsetWidth,
        height: element.offsetHeight
      };
      strings.push(elementData);
  }
  return strings;
}

function renderEntity(index) {
  if (index >= entities.length) {
    // create the diagram
    $("#entities").html("");
    setTimeout(createDiagram, 100);
    return;
  }
  html2canvas($(".entity")[index], {
    onrendered: function(canvas) {
      var data = canvas.toDataURL();
      renderedEntities.push(data);
      var img = Mustache.render(templates.data, {data: data}); 
      $(document.body).append(img);

      renderEntity(index + 1);
    }
  });
}

function startCreatingDiagram() {
  renderedEntities = [];
  renderEntity(0);
}

function createDiagram() {
  var entitySizes = getElementSizes();

  var nodes = [];
  var edges = [];

  var edgesToCentral = [];
  var maxEdgeLength = 0;
  for (var i = 0; i < entities.length; i++) {
    var entity = entities[i];
    var data = entitySizes[i];
    var length = Math.max(data.width, data.height) * 1.5;
    var hasDependencies = false;

    maxEdgeLength = Math.max(maxEdgeLength, length);

    nodes.push({id: entity.id, label: undefined, image: renderedEntities[i], shape: "image", shapeProperties: {useImageSize: true } });
    if (entity.superClass != undefined && entity.superClass > 0) {
      edges.push({from: entity.superClass, to: entity.id, length: length, color: colorSuperClass, label: "inherits", arrows: {from: true} });
      
      hasDependencies = true;
    }

    var extEdges = getEdges(entity.id, entity.extensions, length, "extends", colorExtension, {from: true});
    var proEdges = getEdges(entity.id, entity.protocols, length, "conforms to", colorProtocol, {to: true});
    var conEdges = getEdges(entity.id, entity.containedEntities, length, "contained in", colorContainedIn, {from: true});

    hasDependencies = hasDependencies && extEdges.length > 0 && proEdges.length > 0 && conEdges.length > 0;

    edges = edges.concat(extEdges);
    edges = edges.concat(proEdges);
    edges = edges.concat(conEdges);

    if (!hasDependencies && useCentralNode)
    {
      edgesToCentral.push({from: entity.id, to: -1, length: length * centralEdgeLengthMultiplier, color: centralNodeColor, arrows: {from: true} });
    }
  }

  if (edgesToCentral.length > 1) {
    edges = edges.concat(edgesToCentral);
    nodes.push({id: -1, label: undefined, shape: "circle", color: centralNodeColor });
  }

  var container = document.getElementById("classDiagram");
  var dataToShow = {
      nodes: nodes,
      edges: edges
  };
  var options = {
      "edges": { "smooth": false },
      "physics": {
        "barnesHut": {
          "gravitationalConstant": -7000,
          "springLength": maxEdgeLength,
          "avoidOverlap": 1
        }
      },
      //configure: true
  };
  network = new vis.Network(container, dataToShow, options);

  $("#entities").html("");
  $("img").remove();

  setTimeout(disablePhysics, 200);
}

function disablePhysics()
{
  var options = {
      "edges": { "smooth": false },
      "physics": { "enabled": false }
  };
  network.setOptions(options);
  $(".loading-overlay").fadeOut("fast");
}

function getEdges(entityId, arrayToBind, edgeLength, label, color, arrows) {
  var result = [];
  if (arrayToBind != undefined && arrayToBind.length > 0) {
      for (var i = 0; i < arrayToBind.length; i++) {
        result.push({from: entityId, to: arrayToBind[i], length: edgeLength, color: color, label: label, arrows: arrows });
      }
  }
  return result;   
}

function setSize() {
  var width = $(window).width();
  var height = $(window).height();

  $("#classDiagram").width(width - 5);
  $("#classDiagram").height(height - 5);
}