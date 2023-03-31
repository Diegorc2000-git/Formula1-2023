//
//  LocalizedKeys.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 27/3/23.
//

import Foundation

struct LocalizedKeys {
    
    struct App {
        static let appName = "app_name".localized // Formula1
    }
    
    struct Generic {
        static let openGallery = "open_allery".localized // Open Gallery
        static let requiredFields = "required_fields".localized // * Required fields
        static let ok = "ok".localized // ok
    }
    
    struct SignIn {
        static let loginButtonTitle = "login_button_title".localized // Login
        static let signupButtonTitle = "signup_button_title".localized // Sign up
        static let noAccount = "no_account".localized // ¿You have no account?
        static let enterWithEmail = "enter_with_email".localized // Enter with Email
        static let enterWithFacebook = "enter_with_facebook".localized // Enter with Faceboo
        static let loginTitle = "login_title".localized // Log in to access the app
        static let emailTextFieldLogin = "email_text_field_login".localized // Enter your email*
        static let passwordTextFieldLogin = "password_text_field_login".localized // Enter your email*
        static let loginButton = "login_button".localized // Log in
    }
    
    struct SignUp {
        static let signunCompleted = "signun_completed".localized // SignUp Completed
        static let signupTitle = "signup_title".localized // Register to access the app.
        static let emailTextFieldSignup = "email_text_field_signup".localized // Enter your email*
        static let surnameTextFieldSignup = "surname_text_field_signup".localized // Enter your User Name*
        static let passwordTextFieldSignup = "password_text_field_signup".localized // Enter your password*
        static let signupButton = "signup_button".localized // Sign Up
        static let choosePhoto = "choose_photo".localized // Choose photo
        static let takePhoto = "take_photo".localized // Take photo
        static let signUpSuccess = "signup_success".localized // Account created successfully, Login
    }
    
    struct TabBar {
        static let latest = "tab_bar_home_latest".localized // Latest
        static let video = "tab_bar_home_video".localized // Video
        static let racing = "tab_bar_home_racing".localized // Racing
        static let standing = "tab_bar_home_standing".localized // Standing
        static let profile = "tab_bar_home_profile".localized // Profile
    }
    
    struct SecondTab {
        static let secondTabTitle = "second_tab_title".localized // Information about F1
        static let menuArCellTitle = "menu_ar_cell_title".localized // Open augmented menu
        static let menuCicuitsCellTitle = "menu_cicuits_cell_title".localized // Open Circuits
        static let menuPilotsCellTitle = "menu_pilots_cell_title".localized // Open Pilots
        static let menuTeamsCellTitle = "menu_teams_cell_title".localized // Open teams"
    }
    
    struct AR {
        static let arTitle = "ar_title".localized // AR Menu
        static let arMenuTitleF1 = "ar_menu_title_f1".localized // Formula One
        static let arMenuTitleSupercars = "ar_menu_title_supercars".localized // Supercars
    }
    
    struct Profile {
        static let profileTitle = "profile_title".localized // Profile
        static let profileEmail = "profile_email".localized // Email:
        static let profileName = "profile_name".localized //Name:
        static let profileBio = "profile_bio".localized // Biography:
        static let profileVinculatedAccountsTitle = "profile_vinculated_accounts_title".localized // Link other accounts to the current session
        static let profileVinculatedEmail = "profile_vinculated_email".localized // Link Email
        static let profileVinculatedFacebook = "profile_vinculated_facebook".localized // Link Facebook account
        static let profileEditProfile = "profile_edit_profile".localized // Edit profile
        static let profileLogOut = "profile_log_out".localized // Logout
        static let editProfileName = "edit_profile_name".localized // Enter your name*:
        static let editProfileSurname = "edit_profile_surname".localized // Enter your last name*:
        static let editProfileBio = "edit_profile_bio".localized // Enter a biography*:
        static let editButton = "edit_button".localized // Edit
        static let editSubtitle = "edit_subtitle".localized // The changes are applied the next time you log in.
        static let fillAllFields = "fill_all_fields".localized // fill in all the fields
    }
    
    struct VinculatedAccounts {
        static let vinculateEmailPassword = "vinculate_email_password".localized // Link Email and Password
        static let vinculateEmailWithSessionAccount = "vinculate_email_with_session_account".localized // Link your email with the session you are currently logged in.
        static let vinculateEnterEmail = "vinculate_enter_email".localized //Enter your email*
        static let vinculateEnterPassword = "vinculate_enter_password".localized // Enter your password*
        static let vinculateButton = "vinculate_button".localized // Link
        static let vinculateAlertAccountVinculated = "vinculate_alert_account_vinculated".localized // Account Linked!
        static let vinculateAlertAccountVinculatedSuccess = "vinculate_alert_account_vinculated_success".localized // ✅ You just linked your account
        static let vinculateAlertAccountVinculatedFailure = "vinculate_alert_account_vinculated_failure".localized // ❌ Error linking account
    }
    
    struct Errors {
        static let error = "error".localized // Error
        static let errorTitle = "error_title".localized // An error has occurred!
        static let emailEmpty = "email_empty".localized // Rellena los campos obligatorios.
        static let passwordNotChar = "password_not_char".localized // La contraseña tiene que ser de al menos 6 digitos.
        static let emailNotValid = "email_not_valid".localized // El email introducido es incorrecto, ejemplo@gmail.com
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
