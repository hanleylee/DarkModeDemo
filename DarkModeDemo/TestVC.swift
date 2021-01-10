//
//  Test.swift
//  HLTest
//
//  Created by Hanley Lee on 2020/09/09.
//  Copyright © 2020 Hanley Lee. All rights reserved.
//

import SnapKit
import UIKit

class TestVC: UIViewController {

    var titleLb: UILabel!
    var stackView: UIStackView!
    var imgView: UIImageView!
    var window: UIWindow?

    var btnDic: [UIButton: Theme] = [:]
    var index: Int = 0


    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // 测试 CGColor
        titleLb.layer.backgroundColor = Tools.makeColor(light: .black, dark: .white).cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Tools.makeColor(light: .white, dark: .black)
        initUI()
        btnDic.keys.forEach { $0.addTarget(self, action: #selector(btnTap(sender:)), for: .touchUpInside) }
    }

    @objc func btnTap(sender: UIButton) {
        guard let type = btnDic[sender] else { return }
        self.btnDic.forEach { $0.key.backgroundColor = $0.value == type ? .blue : .gray }
        self.changeTheme(theme: type)
    }

    /// 更改主题
    func changeTheme(theme: Theme) {
        Tools.style = theme
        guard let window = window else { return }
        if #available(iOS 13.0, *) { // 区分版本
            UIView.transition (with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { // 增加转场动画
                window.overrideUserInterfaceStyle = theme.mode // 重置系统模式
            }, completion: nil)
        } else {
            guard let rootVC = window.rootViewController else { return }
            let tabbar = Tools.getTabVC(withIndex: self.index)
            UIView.transition(from: rootVC.view, to: tabbar.view, duration: 0.5, options: [.transitionCrossDissolve], completion: { _ in
                window.rootViewController = tabbar // 重置 tabVC
            })
        }
    }

    func makeBtn(type: Theme) {
        let btn = UIButton()
        btn.setTitle(type.title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .gray
        stackView.addArrangedSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width / 4)
        }

        btnDic[btn] = type
    }
}

extension TestVC {
    func initUI() {
        // 测试 NSAttributedString
        let attriStr = NSMutableAttributedString(string: "VC: \(index)")
        attriStr.setAttributes([.font: UIFont.boldSystemFont(ofSize: 50),
                                .foregroundColor: Tools.makeColor(light: .red, dark: .green)],
                               range: NSRange(location: 0, length: attriStr.length))
        titleLb = UILabel()
        titleLb.attributedText = attriStr
        // 测试 UIColor
        titleLb.layer.backgroundColor = Tools.makeColor(light: .black, dark: .white).cgColor
        titleLb.textAlignment = .center
        view.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0

        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }

        Theme.allCases.forEach { (type) in
            if type == .none {
                if #available(iOS 13.0, *) {
                    makeBtn(type: type)
                }
            } else {
                makeBtn(type: type)
            }
        }

        // 测试 UIImageView
        imgView = .init()
        imgView.image = Tools.makeImage(light: UIImage(named: "avatar")!, dark: UIImage(named: "devJourney")!)
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}
