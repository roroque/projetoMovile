//
// Autogenerated by Natalie - Storyboard Generator Script.
// http://blog.krzyzanowskim.com
//

import UIKit

//MARK: - Storyboards
struct Storyboards {

    struct Main {

        static let identifier = "Main"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> CustomNavigationController! {
            return self.storyboard.instantiateInitialViewController() as! CustomNavigationController
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, Printable {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, Printable {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             

    var description: String { return self.rawValue } 
}

//MARK: - SegueProtocol
public protocol IdentifiableProtocol: Equatable {
    var identifier: String? { get }
}

public protocol SegueProtocol: IdentifiableProtocol {
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
   return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
   return lhs.identifier == rhs
}

//MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? {get}
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

//MARK: - UIViewController extension
extension UIViewController {
    func performSegue<T: SegueProtocol>(segue: T, sender: AnyObject?) {
       performSegueWithIdentifier(segue.identifier, sender: sender)
    }

    func performSegue<T: SegueProtocol>(segue: T) {
       performSegue(segue, sender: nil)
    }
}

//MARK: - UICollectionView

extension UICollectionView {

    func dequeueReusableCell<T: ReusableViewProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> UICollectionViewCell? {
        if let identifier = reusable.identifier {
            return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: forIndexPath) as? UICollectionViewCell
        }
        return nil
    }

    func registerReusableCell<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            registerClass(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, forIndexPath: NSIndexPath!) -> UICollectionReusableView? {
        if let identifier = reusable.identifier {
            return dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: identifier, forIndexPath: forIndexPath) as? UICollectionReusableView
        }
        return nil
    }

    func registerReusable<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            registerClass(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableView

extension UITableView {

    func dequeueReusableCell<T: ReusableViewProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> UITableViewCell? {
        if let identifier = reusable.identifier {
            return dequeueReusableCellWithIdentifier(identifier, forIndexPath: forIndexPath) as? UITableViewCell
        }
        return nil
    }

    func registerReusableCell<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            registerClass(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.identifier {
            return dequeueReusableHeaderFooterViewWithIdentifier(identifier) as? UITableViewHeaderFooterView
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
             registerClass(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}


//MARK: - EpisodeViewController

//MARK: - DateViewController

//MARK: - CustomNavigationController

//MARK: - CustomNavigationController

//MARK: - SeasonViewController
extension UIStoryboardSegue {
    func selection() -> SeasonViewController.Segue? {
        if let identifier = self.identifier {
            return SeasonViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension SeasonViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case goToEpisode = "goToEpisode"

        var kind: SegueKind? {
            switch (self) {
            case goToEpisode:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case goToEpisode:
                return EpisodeViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension SeasonViewController { 

    enum Reusable: String, Printable, ReusableViewProtocol {
        case basicCell = "basicCell"

        var kind: ReusableKind? {
            switch (self) {
            case basicCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case basicCell:
                return CustomTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowsViewController
extension UIStoryboardSegue {
    func selection() -> ShowsViewController.Segue? {
        if let identifier = self.identifier {
            return ShowsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowsViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case goToSeason = "goToSeason"
        case goToShows = "goToShows"

        var kind: SegueKind? {
            switch (self) {
            case goToSeason:
                return SegueKind(rawValue: "show")
            case goToShows:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case goToSeason:
                return SeasonViewController.self
            case goToShows:
                return ShowSeasonsViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension ShowsViewController { 

    enum Reusable: String, Printable, ReusableViewProtocol {
        case collectionCell = "collectionCell"

        var kind: ReusableKind? {
            switch (self) {
            case collectionCell:
                return ReusableKind(rawValue: "collectionViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case collectionCell:
                return CustomCollectionViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowSeasonsViewController
extension ShowSeasonsViewController { 

    enum Reusable: String, Printable, ReusableViewProtocol {
        case seasonCell = "seasonCell"

        var kind: ReusableKind? {
            switch (self) {
            case seasonCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case seasonCell:
                return SeasonTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

