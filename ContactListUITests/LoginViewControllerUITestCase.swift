//
//  LoginViewControllerUiTestCase.swift
//  ContactListUITests
//
//  Created by Manjit on 05/04/2021.
//

import XCTest
@testable import ContactList

class LoginViewControllerUITestCase: XCTestCase {

    var loginViewController: LoginViewController?
   lazy var theme = LoginTheme()
   lazy var viewModel = LoginViewModel(endPoint: LoginEndPointMock())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        let  rootNavController =  RootNavigator(nav: UINavigationController())
        let loginNavigator = LoginNavigator(navigationController: rootNavController.navigationController!)
        loginViewController = LoginViewController(navigator: loginNavigator, viewModel: viewModel, theme: theme)
        loginViewController?.viewDidLoad()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        self.loginViewController = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testKeyBoardType() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        let textFieldUserName = try XCTUnwrap(loginViewController?.loginView.userNameTextField,"textfiled not connect")
        XCTAssertEqual(textFieldPasscode.textContentType, .password, "Missmatch")
        XCTAssertEqual(textFieldUserName.textContentType, .username, "Missmatch")
        XCTAssertEqual(textFieldUserName.returnKeyType, .next, "Missmatch")
        XCTAssertEqual(textFieldPasscode.returnKeyType, .done, "Missmatch")
    }
    func testPasscodeIsSeCureFiled() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        XCTAssertTrue(textFieldPasscode.isSecureTextEntry, "Password UITextField is not a Secure Text Entry Fieldg")
   }
    func testTextPlaceHolder() throws {
        let textFieldPasscode = try XCTUnwrap(loginViewController?.loginView.passCodeTextField,"textfiled not connect")
        let textFieldUserName = try XCTUnwrap(loginViewController?.loginView.userNameTextField,"textfiled not connect")
        XCTAssertEqual(textFieldUserName.placeholder, "Enter username", "Missmatch")
        XCTAssertEqual(textFieldPasscode.placeholder, "Enter passcode", "Missmatch")
    }
    func testbackGroundColor () throws {
        let view = try XCTUnwrap(loginViewController?.view,"textfiled not connecteds")
        XCTAssertEqual(view.backgroundColor,theme.backGroundColor, "Mismatch")
    }
    func testLoginBtnTap() throws {
        let loginButton = try XCTUnwrap(loginViewController?.loginView.loginButton,"button not connect")
        loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(loginButton.titleLabel?.text,"Login","Missmatch")
    }
    func testCheckLoginViewExist() {
        if let loginView = self.loginViewController?.loginView, let subViews = self.loginViewController?.view.subviews {
            XCTAssertTrue(subViews.contains(loginView),"loginview view not loadded")
        } else {
            XCTFail("no superview added")
        }
    }
    func testViewLoades() {
        XCTAssertNotNil(self.loginViewController?.view ,"View is not loaded til now")
    }
    //TODO FUTURE
//    func testLoginsubView() {
//        if let loginView = self.loginViewController?.loginView {
////            XCTAssertTrue(loginView.subviews.contains(loginView.userNameTextField)," username view not loadded")
//            XCTAssertTrue(loginView.subviews.contains(loginView.passCodeTextField)," passCodeTextField view not loadded")
//            XCTAssertTrue(loginView.subviews.contains(loginView.loginButton)," loginButton view not loadded")
//        } else {
//            XCTFail("no superview added")
//        }
//
//    }

}
