import UIKit

class ToastManager {
    
    static let shared = ToastManager()  // Singleton instance

    func showToast(on viewController: UIViewController, message: String, duration: TimeInterval = 3.0) {

        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 20
        toastContainer.clipsToBounds = true

        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.clipsToBounds = true
        toastLabel.backgroundColor = UIColor.clear

        toastContainer.addSubview(toastLabel)
        viewController.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 10),
            toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -10),
            toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 20),
            toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -20),
            toastContainer.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20),
            toastContainer.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -20),
            toastContainer.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])

        UIView.animate(withDuration: 0.5, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
