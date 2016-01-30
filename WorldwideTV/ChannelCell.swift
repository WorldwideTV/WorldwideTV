import UIKit

extension UIView{
    
    func boundInside(superView: UIView){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics:nil, views:["subview":self]))
        
    }
}

class ChannelCell: UICollectionViewCell {
    
    lazy var logoView: UIImageView      = self.makeLogoView()
    lazy var titleLabel: UILabel        = self.makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
        
        contentView.backgroundColor = UIColor.brownColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(logoView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        let views = ["logoView": logoView, "titleLabel": titleLabel]
        var constraints: [NSLayoutConstraint] = []
        
        logoView.boundInside(contentView)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeLogoView() -> UIImageView {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.backgroundColor = UIColor.yellowColor()

        return i
    }
    
    func makeTitleLabel() -> UILabel {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = UIColor.whiteColor()
        
        return l
    }
    
}
