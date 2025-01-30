//
//  InfoButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit

class InfoButton: UIButton {

    init(icon: UIImage) {
        super.init(frame: .zero)
        configuration = .infoButtonStyle(icon: icon)
        // 이렇게 해야 폰트 사이즈가 적용이됨,,,,?
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12)
            return outgoing
        }
        tintColor = .cinePrimaryGray
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
