//
//  HomeViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 24/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import FanMenu
import Macaw
import fluid_slider
import BEMCheckBox
import PopupDialog

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    // MARK: - SearchBar
    var searchBarWithDelegate: DAOSearchBar!
    let innerSpacing: CGFloat = 100.0
    let marginX: CGFloat = 50.0
    let marginY: CGFloat = 15
    let searchBarHeight: CGFloat = 30.0
    let searchBarOriginalWidth: CGFloat = 44.0
    var searchBarWidth: CGFloat = 310.0
    var searchBarDestinationFrame = CGRect.zero
    
    //  MARK: - Constraints
    @IBOutlet weak var heightConstraintPicker: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintBoxDistance: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintBoxDistance: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintBoxPrice: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintBoxPrice: NSLayoutConstraint!
    
    //    MARK: - CheckBox
    @IBOutlet weak var chBoxDistance: BEMCheckBox!
    @IBOutlet weak var chBoxPrice: BEMCheckBox!
    @IBOutlet weak var chBoxTypeRestaurant: BEMCheckBox!
    
    
    @IBOutlet weak var blurEffectMenuFloating: UIVisualEffectView!
    
    @IBOutlet weak var pickerTypeFood: UIPickerView!
    //    MARK: - Slider
    @IBOutlet weak var sliderDistancia: Slider!
    @IBOutlet weak var sliderPorPersona: Slider!
    
    
    @IBAction func sliderPorPersonaClicked(_ sender: Slider) {
        numberAveragePorPersona = Float(round(sender.fraction * 100))
        
    }
    @IBAction func sliderDistanciaClicked(_ sender: Slider) {
        numberAverageDistancia = (Float(round(sender.fraction * 12)) )
        
    }
    
    //    MARK: - View
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet var effectBlurView: UIView!
    @IBOutlet var filter: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var labelAlertView: UILabel!
    
    @IBOutlet weak var fanMenu: FanMenu!
    
    var effect:UIVisualEffect!
    var lastVelocityYSign = 0
    var searchFilter: SearchFilter? = nil
    var selectionTypeFood:String? = nil
    var numberAveragePorPersona: Float? = nil
    var numberAverageDistancia: Float? = nil
    
    var listRestaurants : [RestaurantElement] = []
    {
        didSet {
            self.homeTableView.reloadData()
        }
    }
    
    var backUpRestaurant: [RestaurantElement] = []
    
    var typeFoods: [String] = [String]()
    
    @IBAction func dismissFilterClicked(_ sender: Any) {
        setUpFilterViewOFF()
        actionFilter()
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        setUpFilterViewON()
    }
    
    //    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.reloadData()
        delegates()
        setupSearchBars()
        setupInitValues()
        setUpView()
        setUpViewMenu()
        setUpSlider()
        setUpCheckBox()
        datafromServer()
    }
    
    override func viewDidLayoutSubviews() {
        fanMenu.updateNode()
    }
    
    func setUpView(){
        typeFoods = ["Americano","Japones","Mexicano","Italiano"]
        homeTableView.backgroundColor = .clear
        labelAlertView.text = Literals.labelAlertView
        alertView.layer.cornerRadius = 15
        alertView.alpha = 0.0
        filter.layer.cornerRadius = 7
        blurEffectMenuFloating.alpha = 0
    }
    
    func actionFilter(){
        let filterViewController = FilterViewController()
        let allOn = filterViewController.AllOn(First: chBoxTypeRestaurant.on, Second: chBoxPrice.on, Third: chBoxDistance.on)
        let twoOn = filterViewController.TwoOn(First: chBoxTypeRestaurant.on, Second: chBoxPrice.on, Third: chBoxDistance.on)
        let thirdOn = filterViewController.oneOn(First: chBoxTypeRestaurant.on, Second: chBoxPrice.on, Third: chBoxDistance.on)
        let fourOn = filterViewController.none(First: chBoxTypeRestaurant.on, Second: chBoxPrice.on, Third: chBoxDistance.on)
        calculateOptionFilter(one: allOn,two: twoOn,three: thirdOn,four: fourOn)
    }
    
    func calculateOptionFilter(one:Bool,two:Bool,three:Bool,four:Bool){
        if one{
            listRestaurants = listRestaurants.filter({
                result in
                if result.type == selectionTypeFood{ return true}
                else{return false}
            })
            print(listRestaurants)
        }else if two{
            
        }else if three{
            
        }else if four{
            
        }
    }
    
    func setUpCheckBox(){
        self.sliderDistancia.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        self.sliderDistancia.isHidden = true
        heightConstraintBoxDistance.constant = 0
        widthConstraintBoxDistance.constant = 0
        
        self.sliderPorPersona.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        self.sliderPorPersona.isHidden = true
        heightConstraintBoxPrice.constant = 0
        widthConstraintBoxPrice.constant = 0
        
        self.pickerTypeFood.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        self.pickerTypeFood.isHidden = true
        heightConstraintPicker.constant = 0
    }
    
    func setUpFilterViewON(){
        self.view.addSubview(effectBlurView)
        self.view.addSubview(filter)
        filter.center = self.view.center
        
        filter.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        effectBlurView.alpha = 0
        filter.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.effectBlurView.alpha = 1
            self.effectBlurView.transform = CGAffineTransform.identity
            self.filter.alpha = 1
            self.filter.transform = CGAffineTransform.identity
        })
    }
    
    func setUpFilterViewOFF(){
        UIView.animate(withDuration: 0.3, animations: {
            self.filter.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.filter.alpha = 0
            self.effectBlurView.alpha = 0
        }){ (success:Bool) in
            self.filter.removeFromSuperview()
            self.effectBlurView.removeFromSuperview()
        }
    }
    
    func setUpSlider() {
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        sliderPorPersona.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 7, weight: .bold), .foregroundColor: UIColor.black])
        }
        sliderPorPersona.setMinimumLabelAttributedText(NSAttributedString(string: "0",attributes: labelTextAttributes))
        sliderPorPersona.setMaximumLabelAttributedText(NSAttributedString(string: "100",attributes: labelTextAttributes))
        sliderPorPersona.fraction = 0.5
        sliderPorPersona.shadowOffset = CGSize(width: 0, height: 10)
        sliderPorPersona.shadowBlur = 5
        sliderPorPersona.shadowColor = UIColor(white: 0, alpha: 0.1)
        sliderPorPersona.contentViewColor = MyColor.greenBtnColor
        sliderPorPersona.valueViewColor = .white
        
        sliderDistancia.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 12) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 7, weight: .bold), .foregroundColor: UIColor.black])
        }
        sliderDistancia.setMinimumLabelAttributedText(NSAttributedString(string: "0",attributes: labelTextAttributes))
        sliderDistancia.setMaximumLabelAttributedText(NSAttributedString(string: "12", attributes: labelTextAttributes))
        sliderDistancia.fraction = 0.5
        sliderDistancia.shadowOffset = CGSize(width: 0, height: 10)
        sliderDistancia.shadowBlur = 5
        sliderDistancia.shadowColor = UIColor(white: 0, alpha: 0.1)
        sliderDistancia.contentViewColor = MyColor.greenBtnColor
        sliderDistancia.valueViewColor = .white
    }
    
    func setUpViewMenu(){
        let items = [
            ("QR", 0xFF703B),
            ("USER", 0xFF703B),
            ("MAP", 0xFF703B),
        ]
        
        fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "menu_plus"),
            color: Color(val: 0x008000)
        )
        
        fanMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: "icon_\(button.0)"),
                color: Color(val: button.1)
            )
        }
        
        fanMenu.menuRadius = 90.0
        fanMenu.duration = 0.2
        fanMenu.delay = 0.05
        fanMenu.interval = (Double.pi, 2 * Double.pi)
        
        fanMenu.onItemDidClick = { button in
            if self.fanMenu.isOpen {
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurEffectMenuFloating.alpha = 0.5
                    self.searchBarWithDelegate.alpha = 0.5
                })
                
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurEffectMenuFloating.alpha = 0
                    self.searchBarWithDelegate.alpha = 1
                })
            }
        }
        
        fanMenu.onItemWillClick = { button in
            switch button.id {
            case "USER":
                self.performSegue(withIdentifier: "seguePerfil", sender: nil)
            case "MAP":
                self.performSegue(withIdentifier: "ToMapFromHome", sender: nil)
            case "QR":
                print("")
            default: break
            }
            
        }
        
        fanMenu.backgroundColor = .clear
    }
    
    func datafromServer(){
        let apirest = APIManager()
        apirest.getAllRestaurants(completion: { result
            in
            let resultsRestaurants = result.first
            self.createListRestaurant(List: resultsRestaurants)
        })
    }
    
    func createListRestaurant(List list:Restaurant?){
        guard let listRestaurants = list else { return }
        let newRestaurant = listRestaurants.filter( {
            result in
            if result.imageURL == nil {
                return false
            }else{
                return true
            }
        })
        self.listRestaurants = newRestaurant
    }
    
    func delegates(){
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.pickerTypeFood.delegate = self
        self.pickerTypeFood.dataSource = self
        self.chBoxTypeRestaurant.delegate = self
        self.chBoxPrice.delegate = self
        self.chBoxDistance.delegate = self
    }
    
    func setupSearchBars(){
        searchBarWithDelegate = DAOSearchBar.init(frame: CGRect(x: marginX, y: marginY, width: searchBarOriginalWidth, height: searchBarHeight))
        var frame = searchBarWithDelegate.frame
        frame.size.width = searchBarWidth
        self.searchBarDestinationFrame = frame
        searchBarWithDelegate.delegate = self
        self.view.addSubview(searchBarWithDelegate)
    }
    
    func setupInitValues () {
        searchBarWidth = self.view.bounds.width - (2 * marginX)
    }
    
    func pickerSelected(Number selection:Int)->String{
        return typeFoods[selection]
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = listRestaurants.count
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageDownloader = ImageDownloader()
        let restaurant = listRestaurants[indexPath.row]
        let identifier = "HomeRestaurant"
        let cell = self.homeTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)as! HomeTableViewCell
        imageDownloader.downloader(URLString: restaurant.imageURL!, completion: { (image:UIImage?) in
            cell.restaurantImage.image = image
        })
        cell.nameRestaurant.text = restaurant.name
        cell.typeRestaurant.text = restaurant.type
        cell.backgroundColor = .clear
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign < 0 {
            self.setView(view: alertView, hidden: false)
        } else if lastVelocityYSign > 0 {
            self.setView(view: alertView, hidden: true)
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        if(hidden == false){
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                view.alpha = 0.5
            })
        }else{
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                view.alpha = 0.0
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8,delay: 0.5,options: .curveEaseOut, animations: {
            cell.alpha = 1
        })
    }
    
    func alphaTableView(Alpha alphaNum:Float){
        homeTableView.alpha = CGFloat(alphaNum)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = ( sender as? HomeTableViewCell) else { return }
        guard let indexPath = self.homeTableView.indexPath(for: item) else { return }
        let restaurant = listRestaurants[indexPath.row]
        let detailRestaurant = segue.destination as? MenuViewController
        detailRestaurant?.restaurant = restaurant
    }
    
}

extension HomeViewController: DAOSearchBarDelegate {
    // MARK: SearchBar Delegate
    func destinationFrameForSearchBar(_ searchBar: DAOSearchBar) -> CGRect {
        return self.searchBarDestinationFrame
    }
    
    func searchBar(_ searchBar: DAOSearchBar, willStartTransitioningToState destinationState: DAOSearchBarState) {
        
    }
    
    func searchBar(_ searchBar: DAOSearchBar, didEndTransitioningFromState previousState: DAOSearchBarState) {
        // Do whatever you deem necessary.
    }
    
    func searchBarDidTapReturn(_ searchBar: DAOSearchBar) {
        guard let textSearch:String = searchBar.searchField.text else { return }
        if !textSearch.isEmpty{
            listRestaurants = listRestaurants.filter({
                result in
                if result.name == textSearch {
                    return true
                }else{
                    return false
                }
            })
            if !listRestaurants.isEmpty{
                alphaTableView(Alpha: 1)
            }else{
                alphaTableView(Alpha: 0)
                setUpPopUp(Title: Literals.missingRestaurantTitle, Message: Literals.missingRestaurantMessage, Image: "404", TitleButtonOK: Literals.titleBotonPopUps)
            }
        }
        else {
            datafromServer()
            alphaTableView(Alpha: 1)
        }
        dismissKeyboard()
    }
    
    func searchBarTextDidChange(_ searchBar: DAOSearchBar) {
        alphaTableView(Alpha: 0)
        datafromServer()
    }
    
    func setUpPopUp(Title title:String,Message message:String,Image image:String,TitleButtonOK titleButtonOk:String){
        let popUp = PopUpPresentation(Title: title, Message: message)
        let imagePopUp = UIImage(named: image)
        let popup = PopupDialog(title: popUp.title, message: popUp.message, image: imagePopUp)
        let buttonOk = DefaultButton(title: titleButtonOk) {
        }
        popup.addButtons([buttonOk])
        self.present(popup, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectionTypeFood = pickerSelected(Number: row)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeFoods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeFoods[row]
    }
}


extension HomeViewController:BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        if chBoxTypeRestaurant.on != true{
            self.initAndEndFilter(ValueBox: 4)
            self.pickerTypeFood.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
            self.pickerTypeFood.isHidden = true
            heightConstraintPicker.constant = 0
        }else{
            self.initAndEndFilter(ValueBox: 1)
            self.pickerTypeFood.frame = CGRect(x: 20,y: 94,width: 266,height: 117)
            self.pickerTypeFood.isHidden = false
            heightConstraintPicker.constant = 117
        }
        if chBoxPrice.on != true{
            self.initAndEndFilter(ValueBox: 5)
            self.sliderPorPersona.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
            self.sliderPorPersona.isHidden = true
            heightConstraintBoxPrice.constant = 0
            widthConstraintBoxPrice.constant = 0
        }else{
            self.initAndEndFilter(ValueBox: 2)
            self.sliderPorPersona.frame = CGRect(x: 26,y: 311,width: 255,height: 25)
            self.sliderPorPersona.isHidden = false
            heightConstraintBoxPrice.constant = 25
            widthConstraintBoxPrice.constant = 255
        }
        if chBoxDistance.on != true{
            self.initAndEndFilter(ValueBox: 6)
            self.sliderDistancia.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
            self.sliderDistancia.isHidden = true
            heightConstraintBoxDistance.constant = 0
            widthConstraintBoxDistance.constant = 0
        }else{
            self.initAndEndFilter(ValueBox: 3)
            self.sliderDistancia.frame = CGRect(x: 26,y: 421,width: 250,height: 25)
            self.sliderDistancia.isHidden = false
            heightConstraintBoxDistance.constant = 25
            widthConstraintBoxDistance.constant = 250
        }
    }
    
    func initAndEndFilter(ValueBox value:Int){
        switch value {
        case 1:
            selectionTypeFood = typeFoods[0]
            break
        case 2:
            self.numberAveragePorPersona = 50
            break
        case 3:
            self.numberAverageDistancia = 6
            break
        case 4:
            selectionTypeFood = Literals.empty
            break
        case 5:
            self.numberAveragePorPersona = 0
            break
        case 6:
            self.numberAverageDistancia = 0
            break
        default:return
        }
    }
    
}

