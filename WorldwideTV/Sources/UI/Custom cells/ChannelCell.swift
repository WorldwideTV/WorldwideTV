import UIKit

class ChannelCell: UICollectionViewCell {
    
    lazy var logoView: UIImageView  = self.makeLogoView()
    lazy var titleLabel: UILabel    = self.makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(logoView)
    }
    
    func setupConstraints() {
        let views = ["logoView": logoView, "titleLabel": titleLabel]
        
        var constraints = NSLayoutConstraint.withFormat([
            "V:|[logoView(==200)]",
            "V:[titleLabel]|",
            "H:|[logoView]|",
            ], views: views)
        
        constraints += [titleLabel.centeredInParentX()]
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeLogoView() -> UIImageView {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.backgroundColor = UIColor.yellowColor()
        i.adjustsImageWhenAncestorFocused = true

        return i
    }
    
    func makeTitleLabel() -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = UIColor.whiteColor()
        
        return l
    }
    
}
