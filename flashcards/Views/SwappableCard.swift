import UIKit

protocol SwappableCardDelegate: AnyObject {
    func didSwipe(direction: String)
}

@IBDesignable
class SwappableCard: UIView {
    
    private var isFront = true
    private let questionLabel = UILabel()
    private let answerLabel = UILabel()
    
    private let swipeOverlay = UIView()
    
    weak var delegate: SwappableCardDelegate?

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var overlayOpacity: CGFloat {
        get { return CGFloat(swipeOverlay.alpha) }
        set { swipeOverlay.alpha = CGFloat(newValue) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupCard()
        addGestureRecognizers()
    }
    
    private func setupCard() {
        backgroundColor = .systemBackground

//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
//        blurEffectView.layer.cornerRadius = 10
//        blurEffectView.clipsToBounds = true

//        addSubview(blurEffectView)
//        sendSubviewToBack(blurEffectView)

        layer.cornerRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)

        setupLabel(questionLabel, hidden: false)
        setupLabel(answerLabel, hidden: true)

        swipeOverlay.frame = bounds
        swipeOverlay.alpha = 0
        addSubview(swipeOverlay)
        sendSubviewToBack(swipeOverlay)
    }

    private func setupLabel(_ label: UILabel, hidden: Bool) {
        label.text = "Quetion and Answer Flashcard" // Default text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = hidden
        label.numberOfLines = 0
        label.textAlignment = .center
        addSubview(label)
        
        if label == questionLabel {
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        } else if label == answerLabel {
            label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func flipCard() {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.questionLabel.isHidden = self.isFront
            self.answerLabel.isHidden = !self.isFront
        }, completion: nil)
        isFront.toggle()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        self.transform = CGAffineTransform(translationX: translation.x, y: 0)
        
        let swipeStrength = min(max(abs(translation.x) / 100, 0), 1)
        swipeOverlay.alpha = swipeStrength * 0.25
        swipeOverlay.backgroundColor = translation.x > 0 ? UIColor.green : UIColor.red
        
        if gesture.state == .ended {
            if abs(translation.x) > 100 {
                let direction = translation.x > 0 ? "right" : "left"
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.removeFromSuperview()
                    self.delegate?.didSwipe(direction: direction)
                })
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.transform = .identity
                    self.swipeOverlay.alpha = 0
                }
            }
        }
    }
    
    func setQuestion(_ text: String) {
        questionLabel.text = text
    }
    
    func setAnswer(_ text: String) {
        answerLabel.text = text
    }
}
