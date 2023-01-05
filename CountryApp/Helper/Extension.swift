//
//  Extension.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit


/**
 * Extensions for UIApplication
 */
extension UIApplication {
    /**
     * Extension for getting current
     * presented controller
     */
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        return presentViewController
    }
}
extension UITabBar {
    func removeTopLine() {
        // remove top line
        if #available(iOS 13.0, *) {
            // ios 13.0 and above
            let appearance = standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundEffect = nil
            // need to set background because it is black in standardAppearance
            appearance.backgroundColor = .white
            standardAppearance = appearance
        } else {
            // below ios 13.0
            let image = UIImage()
            shadowImage = image
            backgroundImage = image
            // background
            backgroundColor = .white
        }
    }
}
/**
 * Extensions for UITableView
 */
extension UITableView {
    var tableContentHeight: CGFloat {
        return visibleCells.map({$0.bounds.height}).reduce(0, +)
    }
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
    
    func scrollToBottom(animated: Bool) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func setAdditionalLoadingIndicator(visible: Bool) {
        DispatchQueue.main.async {
            if visible {
                let indicator = UIActivityIndicatorView(style: .medium)
                indicator.frame.size.height = 64
                indicator.frame.size.width = self.bounds.width
                self.tableFooterView = indicator
                indicator.startAnimating()
            } else {
                self.tableFooterView = nil
            }
        }
    }
}

/**
 * Extensions for UIImage
 */
extension UIImage {
    
    func resizeImage(_ dimension: CGFloat, opaque: Bool = false, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
    
    enum PNGQuality: CGFloat {
        case lowest  = 0.0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1.0
    }
    func jpeg(_ jpegQuality: PNGQuality = .medium) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
/**
 * Extensions for UIImageView
 */
extension UIImageView {
    func setImage(from base64String: String) {
        guard let data = Data(base64Encoded: base64String) else {return}
        image = UIImage(data: data)
    }
    /**
     * Function for changing tint color of UIImageView
     */
    func changeTintColor(to color: UIColor) {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
/**
 * Extensions for UIScrollView
 */
extension UIScrollView {
    
    /**
     * Function for scrolling to a specific view so that it's top is at the top our scrollview
     */
    func scrollToView(view: UIView, animated: Bool) {
        guard let origin = view.superview else {return}
        // Get the Y position of your child view
        let childStartPoint = origin.convert(view.frame.origin, to: self)
        // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
        self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y - 64, width: 1, height: self.frame.height), animated: animated)
    }
}

/**
 * Extensions for UIStackView
 */
extension UIStackView {
    /**
     * Function for removing all views into stackView
     */
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
/**
 * Extensions for NSLayoutConstraint
 */
extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" // you may print whatever you want here
    }
}
extension Date {
    static var currentTimeStamp: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    func getTimeStamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    static func time(since fromDate: Date) -> String {
        //        guard fromDate < Date() else { return "Back to the future" }
        
        let allComponents: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components:DateComponents = Calendar.current.dateComponents(allComponents, from: fromDate, to: Date())
        
        
        let arr = [
            ("year", components.year ?? 0),
            ("month", components.month ?? 0),
            ("week", components.weekOfYear ?? 0),
            ("day", components.day ?? 0),
            ("hour", components.hour ?? 0),
            ("minute", components.minute ?? 0),
            ("second", components.second ?? 0),
        ]
        for (period, timeAgo) in arr {
            if timeAgo > 0 {
                return "\(timeAgo.of(period)) ago"
            }
        }
        
        return "Just now"
    }
}
extension Int {
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
    func getSinceDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self / 1000))
        return Date.time(since: date)
    }
    func getDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}
extension String {
    func getFirstLetters(with limitCount: Int = 2) -> String {
        var count = 0
        let string = self.components(separatedBy: " ")
        var firstChars = ""
        for words in string {
            guard count != limitCount else {break}
            firstChars += (words.first?.description ?? "").uppercased()
            count += 1
        }
        return firstChars
    }
    func clearStringFromSpaces() -> String {
        return trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
    }
    func stringAmountToDouble() -> Double {
        return (Double(replacingOccurrences(of: ",", with: ".")) ?? 0).rounded(toPlaces: 2)
    }
    func firstCharacterUpperCase() -> String? {
        guard !isEmpty else { return nil }
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    private func mod97() -> Int {
        let symbols: [Character] = Array(self)
        let swapped = symbols.dropFirst(4) + symbols.prefix(4)
        
        let mod: Int = swapped.reduce(0) { (previousMod, char) in
            let value = Int(String(char), radix: 36)! // "0" => 0, "A" => 10, "Z" => 35
            let factor = value < 10 ? 10 : 100
            return (factor * previousMod + value) % 97
        }
        
        return mod
    }
    
    func passesMod97Check() -> Bool {
        guard self.count >= 4 else {
            return false
        }
        
        let uppercase = self.uppercased()
        
        guard uppercase.range(of: "^[0-9A-Z]*$", options: .regularExpression) != nil else {
            return false
        }
        
        return uppercase.mod97() == 1
    }
}
extension URL {
    func deleteFile() throws {
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: self)
    }
    
    func deleteFileNotThrows() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: self)
        } catch let error {
            print(error)
        }
        
    }
    func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
    
    func createFolderIfNotExists(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        let dir = self
        let folderURL = dir.appendingPathComponent(folderName)
        // If folder URL does not exist, create it
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                // Attempt to create folder
                try fileManager.createDirectory(atPath: folderURL.path,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
            } catch {
                // Creation failed. Print error & return nil
                return nil
            }
        }
        // Folder either exists, or was created. Return URL
        return folderURL
    }
}
/**
 * Extensions for UIView
 */
extension UIView {
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            (degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    /**
     * Function for hide loading, its commonly using when showing alert
     */
    func hideLoading() {
        if let loading = UIApplication.getPresentedViewController()?.view.viewWithTag(1121) {
            UIView.animate(withDuration: 1.0, animations: {
                loading.alpha = 0.0
            }, completion: { _ in
                loading.removeFromSuperview()
            })
        }
    }
    
    
    /**
     * Function for changing visibility with animation (show with animation or hide with animation)
     */
    func setVisibilityWithAnimation(isHidden: Bool, duration: TimeInterval = 0.5) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.isHidden = isHidden
        })
    }
    func dropShadow(radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? 0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.12).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 12)
        layer.shadowRadius = 16
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}


/**
 * Extensions for UIViewController
 */
extension UIViewController {
    /**
     * Function for going back simple, popping view controller from navigation controller
     */
    @objc func goBackSimple() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
    /**
     * Function for dismissing simple, dismiss view controller
     */
    @objc func dismissSimple() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
    }
    @objc func dismissWithCompletion(completion: ( () -> Void )?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: completion)
        }
    }
    /**
     * Function for setupping modal
     */
    func setupModal(presentationStyle: UIModalPresentationStyle = .overCurrentContext, transitionStyle: UIModalTransitionStyle = .coverVertical) {
        modalPresentationStyle = presentationStyle
        modalTransitionStyle = transitionStyle
    }
    /**
     * Function for hiding keyboard when tapping around of keyboard
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    /**
     * Function for dismissing keyboard (ending editing)
     */
    @objc func dismissKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    func openSafari(via link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    /**
     * Function for presenting modal in main queue
     */
    func presentVC(_ screen: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            //            self.hideLoading()
            self.view.endEditing(true)
            self.present(screen, animated: animated, completion: completion)
        }
    }
    /**
     * Function for pushing vc in main queue
     */
    func pushVC(_ screen: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            if let nav = self.navigationController {
                nav.pushViewController(screen, animated: animated)
                return
            }
            
            if let nav = self as? UINavigationController {
                nav.pushViewController(screen, animated: animated)
                return
            }
        }
    }
    func popVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func showConfirmationAlert(
        title: String = "confirmation_alert_title", message: String = "confirmation_alert_description",
        confirmTitle: String = "confirmation_alert_confirm_button_title", cancelTitle: String = "confirmation_alert_cancel_button_title",
        onConfirm: (() -> Void)?
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { _ in
            onConfirm?()
        }))
        if !cancelTitle.isEmpty {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        }
        presentVC(alert, animated: true)
    }
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertController.view.tintColor = UIColor.mainGreen
        presentVC(alertController, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        alertController.view.tintColor = UIColor.mainGreen
        presentVC(alertController, animated: true, completion: nil)
    }
    
    func showMessage(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertController.view.tintColor = UIColor.mainGreen
        presentVC(alertController, animated: true, completion: nil)
    }
    
    func showMessage(_ title: String, _ message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        alertController.view.tintColor = UIColor.mainGreen
        presentVC(alertController, animated: true, completion: nil)
    }
    static var activityIndicatorTag = 12345

    func startLoading() {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = UIViewController.activityIndicatorTag
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        
        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        let activityIndicator = view.viewWithTag(UIViewController.activityIndicatorTag) as? UIActivityIndicatorView
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
        }
    }
}
extension Float {
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
/**
 * Extensions for UIViewController
 */
import CommonCrypto
extension String {
    func hmac(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), key, key.count, self, self.count, &digest)
        let data = Data(digest)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            if !scalar.properties.isEmoji { continue }
            return true
        }
        return false
    }
    func formattedDate(inputFormat: String = "dd/MM/yyyy", outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        }
        return nil
    }
    /**
     * Function for setting up variables localized
     */
    //    func localized(with arguments: [CVarArg]) -> String {
    //        return String(format: self.localized(), locale: nil, arguments: arguments)
    //    }
    /**
     * Function for checking string is email or not
     */
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    /**
     * Function for ENCODING url string
     */
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    /**
     * Function for DECODING url string
     */
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
    /**
     * Function for converting html code to NSAttributedString
     */
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    /**
     * Function for converting html code to String
     */
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    /**
     * Function for removing all spaces from string
     */
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pureNumber)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    //    func formatedDate(showTime: Bool = false) -> String? {
    //        var format = "dd MMM yyyy"
    //        if showTime {
    //            format += " HH:mm"
    //        }
    //        return toDate()?.toString(.custom(format))
    //    }
    //
    //    func formatedTime() -> String? {
    //        return toDate()?.toString(.custom("HH:mm"))
    //    }
    
    func toJson<T: Decodable>() -> T? {
        guard let jsonData = data(using: String.Encoding.utf8) else {return nil}
        do {
            let objc = try JSONDecoder().decode(T.self, from: jsonData)
            return objc
        } catch {
            print(error)
            return nil
        }
    }
}
extension UINavigationController {
    public func hasViewController(ofKind kind: AnyClass) -> UIViewController? {
        return self.viewControllers.first(where: {$0.isKind(of: kind)})
    }
    func pushToNav(_ screen: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.pushViewController(screen, animated: animated)
        }
    }
}
extension Dictionary {
    func toString() -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
    }
}
/**
 * Extensions for Double
 */
extension Double {
    /**
     * Function for rounding double to decimal places value
     */
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
