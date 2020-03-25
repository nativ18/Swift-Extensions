extension UIView: NibReusable {

     class func loadNibInside<T: UIView>(ofType: T.Type, containerView: UIView) -> T {
        let view = T.instantiate() as! T
        view.fill(in: containerView)
        return view
    }

    public class func instantiate<T: UIView>() -> T {

        return nib.instantiate(withOwner: nil, options: nil).first as! T
    }

    @discardableResult
    public func fill(in view: UIView) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {

        if view.subviews.contains(self) == false {
            view.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false
        let left = leadingAnchor.constraint(equalTo: view.leadingAnchor)
        left.isActive = true
        let right = trailingAnchor.constraint(equalTo: view.trailingAnchor)
        right.isActive = true
        let top = topAnchor.constraint(equalTo: view.topAnchor)
        top.isActive = true
        let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottom.isActive = true
        return (left, right, top, bottom)
    }
}



public protocol NibReusable: Reusable {

    static var nib: UINib { get }
}

public extension NibReusable {

    public static var nib: UINib {
        let name = NSStringFromClass(self).components(separatedBy: ".").last!
        return UINib(nibName: name, bundle: Bundle(for: self))
    }
}


public protocol Reusable: class {

    static var reuseIdentifier: String { get }
}

public extension Reusable {

    public static var reuseIdentifier: String {
        let name = NSStringFromClass(self).components(separatedBy: ".").last!
        return name
    }
}
