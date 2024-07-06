// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Your device is rooted`
  String get YourDeviceRooted {
    return Intl.message(
      'Your device is rooted',
      name: 'YourDeviceRooted',
      desc: '',
      args: [],
    );
  }

  /// `You can not use SunoKitaab untill your device is unrooted`
  String get YouSunoKitaab {
    return Intl.message(
      'You can not use SunoKitaab untill your device is unrooted',
      name: 'YouSunoKitaab',
      desc: '',
      args: [],
    );
  }

  /// `Your Downloads`
  String get YourDownloads {
    return Intl.message(
      'Your Downloads',
      name: 'YourDownloads',
      desc: '',
      args: [],
    );
  }

  /// `Your Subscription is Expired`
  String get YourSubscriptionExpired {
    return Intl.message(
      'Your Subscription is Expired',
      name: 'YourSubscriptionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Please go back online and buy subscription to access all downloaded lectures!`
  String get PleaseGoBackOnline {
    return Intl.message(
      'Please go back online and buy subscription to access all downloaded lectures!',
      name: 'PleaseGoBackOnline',
      desc: '',
      args: [],
    );
  }

  /// `Your don't have a subscription`
  String get YourDontHaveSubscription {
    return Intl.message(
      'Your don\'t have a subscription',
      name: 'YourDontHaveSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Please go back online and buy subscription to download lectures`
  String get Pleaselectures {
    return Intl.message(
      'Please go back online and buy subscription to download lectures',
      name: 'Pleaselectures',
      desc: '',
      args: [],
    );
  }

  /// `Can't authenticate with Truecaller, please try another method`
  String get CanTruecaller {
    return Intl.message(
      'Can\'t authenticate with Truecaller, please try another method',
      name: 'CanTruecaller',
      desc: '',
      args: [],
    );
  }

  /// `User already exists please try logging in instead`
  String get AlreadyExists {
    return Intl.message(
      'User already exists please try logging in instead',
      name: 'AlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `signature`
  String get signature {
    return Intl.message(
      'signature',
      name: 'signature',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong please try again later`
  String get SomethingWrong {
    return Intl.message(
      'Something went wrong please try again later',
      name: 'SomethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get PleaseWait {
    return Intl.message(
      'Please wait...',
      name: 'PleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get YourName {
    return Intl.message(
      'Your Name',
      name: 'YourName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Your name must contain more than 2 characters`
  String get YourNameContain {
    return Intl.message(
      'Your name must contain more than 2 characters',
      name: 'YourNameContain',
      desc: '',
      args: [],
    );
  }

  /// `Check your phone number, it should contain only 10 digits`
  String get Checkyourphone {
    return Intl.message(
      'Check your phone number, it should contain only 10 digits',
      name: 'Checkyourphone',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get OR {
    return Intl.message(
      'OR',
      name: 'OR',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get LogIn {
    return Intl.message(
      'Log In',
      name: 'LogIn',
      desc: '',
      args: [],
    );
  }

  /// `Correct your phone number`
  String get Correctyourphone {
    return Intl.message(
      'Correct your phone number',
      name: 'Correctyourphone',
      desc: '',
      args: [],
    );
  }

  /// `If Didn't Get the OTP Press Resend in`
  String get OTPmessage {
    return Intl.message(
      'If Didn\'t Get the OTP Press Resend in',
      name: 'OTPmessage',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get ChangePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'ChangePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get GoBack {
    return Intl.message(
      'Go Back',
      name: 'GoBack',
      desc: '',
      args: [],
    );
  }

  /// `Get your Educational Board narrated and explained by great teachers`
  String get GetyourEducationalBoard {
    return Intl.message(
      'Get your Educational Board narrated and explained by great teachers',
      name: 'GetyourEducationalBoard',
      desc: '',
      args: [],
    );
  }

  /// `Let us know you a little before\nyou begin learning`
  String get Letusknow {
    return Intl.message(
      'Let us know you a little before\nyou begin learning',
      name: 'Letusknow',
      desc: '',
      args: [],
    );
  }

  /// `Search your school`
  String get SearchSchool {
    return Intl.message(
      'Search your school',
      name: 'SearchSchool',
      desc: '',
      args: [],
    );
  }

  /// `No School Found!`
  String get NoSchoolFound {
    return Intl.message(
      'No School Found!',
      name: 'NoSchoolFound',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some more keywords`
  String get Pleaseentersomekeywords {
    return Intl.message(
      'Please enter some more keywords',
      name: 'Pleaseentersomekeywords',
      desc: '',
      args: [],
    );
  }

  /// `or if you didn't found your school`
  String get foundyourschool {
    return Intl.message(
      'or if you didn\'t found your school',
      name: 'foundyourschool',
      desc: '',
      args: [],
    );
  }

  /// `Enter School Name`
  String get EnterSchoolName {
    return Intl.message(
      'Enter School Name',
      name: 'EnterSchoolName',
      desc: '',
      args: [],
    );
  }

  /// `Submit Your School Name`
  String get SubmitYourSchoolName {
    return Intl.message(
      'Submit Your School Name',
      name: 'SubmitYourSchoolName',
      desc: '',
      args: [],
    );
  }

  /// `School Name`
  String get SchoolName {
    return Intl.message(
      'School Name',
      name: 'SchoolName',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred please try again later`
  String get ErrorAgainlater {
    return Intl.message(
      'An error occurred please try again later',
      name: 'ErrorAgainlater',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get WelcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'WelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get LoginYourAccount {
    return Intl.message(
      'Login to your account',
      name: 'LoginYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please provide valid phone number`
  String get validphonenumber {
    return Intl.message(
      'Please provide valid phone number',
      name: 'validphonenumber',
      desc: '',
      args: [],
    );
  }

  /// `By Signing Up/In, you agree to our `
  String get BySigning {
    return Intl.message(
      'By Signing Up/In, you agree to our ',
      name: 'BySigning',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get TermsService {
    return Intl.message(
      'Terms of Service',
      name: 'TermsService',
      desc: '',
      args: [],
    );
  }

  /// ` and that you have read our `
  String get haveread {
    return Intl.message(
      ' and that you have read our ',
      name: 'haveread',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the otp that you've received on`
  String get Pleaseprovidetheotp {
    return Intl.message(
      'Please provide the otp that you\'ve received on',
      name: 'Pleaseprovidetheotp',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get Choose {
    return Intl.message(
      'Choose',
      name: 'Choose',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get State {
    return Intl.message(
      'State',
      name: 'State',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get District {
    return Intl.message(
      'District',
      name: 'District',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get Student {
    return Intl.message(
      'Student',
      name: 'Student',
      desc: '',
      args: [],
    );
  }

  /// `Teacher`
  String get Teacher {
    return Intl.message(
      'Teacher',
      name: 'Teacher',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get Parent {
    return Intl.message(
      'Parent',
      name: 'Parent',
      desc: '',
      args: [],
    );
  }

  /// `Aspirant`
  String get Aspirant {
    return Intl.message(
      'Aspirant',
      name: 'Aspirant',
      desc: '',
      args: [],
    );
  }

  /// `Books in Cart`
  String get BooksCart {
    return Intl.message(
      'Books in Cart',
      name: 'BooksCart',
      desc: '',
      args: [],
    );
  }

  /// `No items in cart, Right now!`
  String get NoItems {
    return Intl.message(
      'No items in cart, Right now!',
      name: 'NoItems',
      desc: '',
      args: [],
    );
  }

  /// `Please try adding books to your cart by tapping on add to cart button on books`
  String get PleaseTryAddingBooks {
    return Intl.message(
      'Please try adding books to your cart by tapping on add to cart button on books',
      name: 'PleaseTryAddingBooks',
      desc: '',
      args: [],
    );
  }

  /// `for`
  String get For {
    return Intl.message(
      'for',
      name: 'For',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Please don't press back`
  String get PleasePressBack {
    return Intl.message(
      'Please don\'t press back',
      name: 'PleasePressBack',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Entire App`
  String get UnlockEntireApp {
    return Intl.message(
      'Unlock Entire App',
      name: 'UnlockEntireApp',
      desc: '',
      args: [],
    );
  }

  /// `More Plans`
  String get MorePlans {
    return Intl.message(
      'More Plans',
      name: 'MorePlans',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, Please try again`
  String get SomethingWentWrong {
    return Intl.message(
      'Something went wrong, Please try again',
      name: 'SomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `School is considered onBoarded!`
  String get SchoolConsidered {
    return Intl.message(
      'School is considered onBoarded!',
      name: 'SchoolConsidered',
      desc: '',
      args: [],
    );
  }

  /// `OnBoard School`
  String get OnBoardSchool {
    return Intl.message(
      'OnBoard School',
      name: 'OnBoardSchool',
      desc: '',
      args: [],
    );
  }

  /// `By tapping on submit, you agree to our `
  String get ByTapping {
    return Intl.message(
      'By tapping on submit, you agree to our ',
      name: 'ByTapping',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service & Policies`
  String get TermsPolicies {
    return Intl.message(
      'Terms of Service & Policies',
      name: 'TermsPolicies',
      desc: '',
      args: [],
    );
  }

  /// `School Address`
  String get SchoolAddress {
    return Intl.message(
      'School Address',
      name: 'SchoolAddress',
      desc: '',
      args: [],
    );
  }

  /// `Units of Vidya Box`
  String get UnitsVidyaBox {
    return Intl.message(
      'Units of Vidya Box',
      name: 'UnitsVidyaBox',
      desc: '',
      args: [],
    );
  }

  /// `Lead By`
  String get LeadBy {
    return Intl.message(
      'Lead By',
      name: 'LeadBy',
      desc: '',
      args: [],
    );
  }

  /// `Notes or Remarks (if any)`
  String get NotesRemarks {
    return Intl.message(
      'Notes or Remarks (if any)',
      name: 'NotesRemarks',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Plan`
  String get ChooseYourPlan {
    return Intl.message(
      'Choose Your Plan',
      name: 'ChooseYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Reference Code!`
  String get InvalidReferenceCode {
    return Intl.message(
      'Invalid Reference Code!',
      name: 'InvalidReferenceCode',
      desc: '',
      args: [],
    );
  }

  /// `Reference Code Applied Successfully!`
  String get ReferenceCodeApplied {
    return Intl.message(
      'Reference Code Applied Successfully!',
      name: 'ReferenceCodeApplied',
      desc: '',
      args: [],
    );
  }

  /// `Apply Reference Code`
  String get ApplyReference {
    return Intl.message(
      'Apply Reference Code',
      name: 'ApplyReference',
      desc: '',
      args: [],
    );
  }

  /// `If you have reference code got from your school or your friend please put it here, to get discounts/offers`
  String get ReferenceMessage {
    return Intl.message(
      'If you have reference code got from your school or your friend please put it here, to get discounts/offers',
      name: 'ReferenceMessage',
      desc: '',
      args: [],
    );
  }

  /// `ReferenceCode`
  String get ReferenceCode {
    return Intl.message(
      'ReferenceCode',
      name: 'ReferenceCode',
      desc: '',
      args: [],
    );
  }

  /// `APPLY`
  String get APPLY {
    return Intl.message(
      'APPLY',
      name: 'APPLY',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get SaveAddress {
    return Intl.message(
      'Save Address',
      name: 'SaveAddress',
      desc: '',
      args: [],
    );
  }

  /// `House Address / Apt. Address / Street Address`
  String get HouseAddress {
    return Intl.message(
      'House Address / Apt. Address / Street Address',
      name: 'HouseAddress',
      desc: '',
      args: [],
    );
  }

  /// `State & District`
  String get StateDistrict {
    return Intl.message(
      'State & District',
      name: 'StateDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Please enter postal code`
  String get Pleasepostalcode {
    return Intl.message(
      'Please enter postal code',
      name: 'Pleasepostalcode',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get PostalCode {
    return Intl.message(
      'Postal Code',
      name: 'PostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Landmark (Optional)`
  String get Landmark {
    return Intl.message(
      'Landmark (Optional)',
      name: 'Landmark',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get EmailAddress {
    return Intl.message(
      'Email Address',
      name: 'EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter address`
  String get Pleaseenteraddress {
    return Intl.message(
      'Please enter address',
      name: 'Pleaseenteraddress',
      desc: '',
      args: [],
    );
  }

  /// `Hello everyone, I am using SunoKitaab App to learn my school syllabus explained by best teachers.\n\nAd-free Audiobook app for School students and competitive exam aspirants.\nDownload Now:`
  String get ShareText {
    return Intl.message(
      'Hello everyone, I am using SunoKitaab App to learn my school syllabus explained by best teachers.\n\nAd-free Audiobook app for School students and competitive exam aspirants.\nDownload Now:',
      name: 'ShareText',
      desc: '',
      args: [],
    );
  }

  /// `What you're looking for?`
  String get WhatLookingFor {
    return Intl.message(
      'What you\'re looking for?',
      name: 'WhatLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get Explore {
    return Intl.message(
      'Explore',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get Library {
    return Intl.message(
      'Library',
      name: 'Library',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Learn & Earn`
  String get LearnEarn {
    return Intl.message(
      'Learn & Earn',
      name: 'LearnEarn',
      desc: '',
      args: [],
    );
  }

  /// `₹15,000 / Month`
  String get Rate {
    return Intl.message(
      '₹15,000 / Month',
      name: 'Rate',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get Downloads {
    return Intl.message(
      'Downloads',
      name: 'Downloads',
      desc: '',
      args: [],
    );
  }

  /// `Ask for Discount`
  String get AskDiscount {
    return Intl.message(
      'Ask for Discount',
      name: 'AskDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get Premium {
    return Intl.message(
      'Premium',
      name: 'Premium',
      desc: '',
      args: [],
    );
  }

  /// `Choose lecture to play`
  String get ChooseToPlay {
    return Intl.message(
      'Choose lecture to play',
      name: 'ChooseToPlay',
      desc: '',
      args: [],
    );
  }

  /// `Choose Read Aloud to play`
  String get ChooseReadAloudPlay {
    return Intl.message(
      'Choose Read Aloud to play',
      name: 'ChooseReadAloudPlay',
      desc: '',
      args: [],
    );
  }

  /// `Explanation`
  String get Explanation {
    return Intl.message(
      'Explanation',
      name: 'Explanation',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get ReadAloud {
    return Intl.message(
      'Reading',
      name: 'ReadAloud',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a subscription to access this chapter :(`
  String get NoSubMessage {
    return Intl.message(
      'You don\'t have a subscription to access this chapter :(',
      name: 'NoSubMessage',
      desc: '',
      args: [],
    );
  }

  /// `Get Subscription`
  String get GetSubscription {
    return Intl.message(
      'Get Subscription',
      name: 'GetSubscription',
      desc: '',
      args: [],
    );
  }

  /// `We're still working on it, please come back later to check!`
  String get Westillworking {
    return Intl.message(
      'We\'re still working on it, please come back later to check!',
      name: 'Westillworking',
      desc: '',
      args: [],
    );
  }

  /// `Search your chapter`
  String get Searchyourchapter {
    return Intl.message(
      'Search your chapter',
      name: 'Searchyourchapter',
      desc: '',
      args: [],
    );
  }

  /// `Please enter keywords to begin search`
  String get PleasekeywordsSearch {
    return Intl.message(
      'Please enter keywords to begin search',
      name: 'PleasekeywordsSearch',
      desc: '',
      args: [],
    );
  }

  /// `Loading chapters please wait`
  String get LoadingPleaseWait {
    return Intl.message(
      'Loading chapters please wait',
      name: 'LoadingPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong\nPlease try again later!`
  String get TryAgain {
    return Intl.message(
      'Something went wrong\nPlease try again later!',
      name: 'TryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unlock this lecture`
  String get UnlockLecture {
    return Intl.message(
      'Unlock this lecture',
      name: 'UnlockLecture',
      desc: '',
      args: [],
    );
  }

  /// `Watch an ad to access only one lecture anytime or buy subscription with 30 days free trial`
  String get WatchLecture {
    return Intl.message(
      'Watch an ad to access only one lecture anytime or buy subscription with 30 days free trial',
      name: 'WatchLecture',
      desc: '',
      args: [],
    );
  }

  /// `Watch an ads`
  String get WatchAds {
    return Intl.message(
      'Watch an ads',
      name: 'WatchAds',
      desc: '',
      args: [],
    );
  }

  /// `There's no ad to show right now`
  String get NoAdsMessage {
    return Intl.message(
      'There\'s no ad to show right now',
      name: 'NoAdsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Start free Trial`
  String get StartTrial {
    return Intl.message(
      'Start free Trial',
      name: 'StartTrial',
      desc: '',
      args: [],
    );
  }

  /// `Choose lecture to play`
  String get ChooseLecture {
    return Intl.message(
      'Choose lecture to play',
      name: 'ChooseLecture',
      desc: '',
      args: [],
    );
  }

  /// `Choose Read Aloud to play`
  String get ChooseRead {
    return Intl.message(
      'Choose Read Aloud to play',
      name: 'ChooseRead',
      desc: '',
      args: [],
    );
  }

  /// `We're still working on it, please come back later to check!`
  String get StillWorking {
    return Intl.message(
      'We\'re still working on it, please come back later to check!',
      name: 'StillWorking',
      desc: '',
      args: [],
    );
  }

  /// `Chapters`
  String get Chapters {
    return Intl.message(
      'Chapters',
      name: 'Chapters',
      desc: '',
      args: [],
    );
  }

  /// `Content creation is in progress`
  String get ContentCreation {
    return Intl.message(
      'Content creation is in progress',
      name: 'ContentCreation',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Bag`
  String get RemoveBag {
    return Intl.message(
      'Remove from Bag',
      name: 'RemoveBag',
      desc: '',
      args: [],
    );
  }

  /// `Add to Bag - `
  String get AddBag {
    return Intl.message(
      'Add to Bag - ',
      name: 'AddBag',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Library`
  String get RemoveLibrary {
    return Intl.message(
      'Remove from Library',
      name: 'RemoveLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Add to Library`
  String get AddLibrary {
    return Intl.message(
      'Add to Library',
      name: 'AddLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Lectures`
  String get Lectures {
    return Intl.message(
      'Lectures',
      name: 'Lectures',
      desc: '',
      args: [],
    );
  }

  /// `Read only Pdf`
  String get ReadPdf {
    return Intl.message(
      'Read only Pdf',
      name: 'ReadPdf',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get GotIt {
    return Intl.message(
      'Got it',
      name: 'GotIt',
      desc: '',
      args: [],
    );
  }

  /// `Long press to add to bag`
  String get LongPress {
    return Intl.message(
      'Long press to add to bag',
      name: 'LongPress',
      desc: '',
      args: [],
    );
  }

  /// `You can buy individual books now\nif you don't want to opt for other subscriptions`
  String get BuyIndividualBook {
    return Intl.message(
      'You can buy individual books now\nif you don\'t want to opt for other subscriptions',
      name: 'BuyIndividualBook',
      desc: '',
      args: [],
    );
  }

  /// `Books`
  String get Books {
    return Intl.message(
      'Books',
      name: 'Books',
      desc: '',
      args: [],
    );
  }

  /// `Cannot add this book because its either already in your cart or you already bought it`
  String get AlreadyInToYourCart {
    return Intl.message(
      'Cannot add this book because its either already in your cart or you already bought it',
      name: 'AlreadyInToYourCart',
      desc: '',
      args: [],
    );
  }

  /// `This book is either already in your cart or you already bought it`
  String get AlreadyBought {
    return Intl.message(
      'This book is either already in your cart or you already bought it',
      name: 'AlreadyBought',
      desc: '',
      args: [],
    );
  }

  /// `Clear Selection`
  String get ClearSelection {
    return Intl.message(
      'Clear Selection',
      name: 'ClearSelection',
      desc: '',
      args: [],
    );
  }

  /// `No Downloads Yet!`
  String get NoDownloads {
    return Intl.message(
      'No Downloads Yet!',
      name: 'NoDownloads',
      desc: '',
      args: [],
    );
  }

  /// `Go download some lectures to make them list here`
  String get GoDownload {
    return Intl.message(
      'Go download some lectures to make them list here',
      name: 'GoDownload',
      desc: '',
      args: [],
    );
  }

  /// `Free Kitaab of the Day!`
  String get FreeKitaabDay {
    return Intl.message(
      'Free Kitaab of the Day!',
      name: 'FreeKitaabDay',
      desc: '',
      args: [],
    );
  }

  /// `LISTEN NOW`
  String get LISTENNOW {
    return Intl.message(
      'LISTEN NOW',
      name: 'LISTENNOW',
      desc: '',
      args: [],
    );
  }

  /// `Academics`
  String get Academics {
    return Intl.message(
      'Academics',
      name: 'Academics',
      desc: '',
      args: [],
    );
  }

  /// `Government Exams`
  String get GovernmentExams {
    return Intl.message(
      'Government Exams',
      name: 'GovernmentExams',
      desc: '',
      args: [],
    );
  }

  /// `Beyond Academics`
  String get BeyondAcademics {
    return Intl.message(
      'Beyond Academics',
      name: 'BeyondAcademics',
      desc: '',
      args: [],
    );
  }

  /// `Podcasts & Stories`
  String get PodcastsStories {
    return Intl.message(
      'Podcasts & Stories',
      name: 'PodcastsStories',
      desc: '',
      args: [],
    );
  }

  /// `Content Coming Soon`
  String get ContentComingSoon {
    return Intl.message(
      'Content Coming Soon',
      name: 'ContentComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `You don't have anything here, try to save something here`
  String get TrySomethingHere {
    return Intl.message(
      'You don\'t have anything here, try to save something here',
      name: 'TrySomethingHere',
      desc: '',
      args: [],
    );
  }

  /// `Your Books`
  String get YourBooks {
    return Intl.message(
      'Your Books',
      name: 'YourBooks',
      desc: '',
      args: [],
    );
  }

  /// `Download Started`
  String get DownloadStarted {
    return Intl.message(
      'Download Started',
      name: 'DownloadStarted',
      desc: '',
      args: [],
    );
  }

  /// `No Subscription`
  String get NoSubscription {
    return Intl.message(
      'No Subscription',
      name: 'NoSubscription',
      desc: '',
      args: [],
    );
  }

  /// `This is a premium feature, please buy a subscription in order to download lectures`
  String get DownloadMessage {
    return Intl.message(
      'This is a premium feature, please buy a subscription in order to download lectures',
      name: 'DownloadMessage',
      desc: '',
      args: [],
    );
  }

  /// `Generating Link`
  String get GeneratingLink {
    return Intl.message(
      'Generating Link',
      name: 'GeneratingLink',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get Download {
    return Intl.message(
      'Download',
      name: 'Download',
      desc: '',
      args: [],
    );
  }

  /// `Adjust volume`
  String get AdjustVol {
    return Intl.message(
      'Adjust volume',
      name: 'AdjustVol',
      desc: '',
      args: [],
    );
  }

  /// `Adjust speed`
  String get AdjustSpeed {
    return Intl.message(
      'Adjust speed',
      name: 'AdjustSpeed',
      desc: '',
      args: [],
    );
  }

  /// `This doesn't happen usually but it seems pdf fetching is failed now we're retrying, please wait`
  String get PdfLoadMessage {
    return Intl.message(
      'This doesn\'t happen usually but it seems pdf fetching is failed now we\'re retrying, please wait',
      name: 'PdfLoadMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get Loading {
    return Intl.message(
      'Loading',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `Your Comment`
  String get YourComment {
    return Intl.message(
      'Your Comment',
      name: 'YourComment',
      desc: '',
      args: [],
    );
  }

  /// `POST`
  String get POST {
    return Intl.message(
      'POST',
      name: 'POST',
      desc: '',
      args: [],
    );
  }

  /// `No comments yet!`
  String get NocommentsYet {
    return Intl.message(
      'No comments yet!',
      name: 'NocommentsYet',
      desc: '',
      args: [],
    );
  }

  /// `Be the first one to comment`
  String get firstcomment {
    return Intl.message(
      'Be the first one to comment',
      name: 'firstcomment',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get Comments {
    return Intl.message(
      'Comments',
      name: 'Comments',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get None {
    return Intl.message(
      'None',
      name: 'None',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `One`
  String get One {
    return Intl.message(
      'One',
      name: 'One',
      desc: '',
      args: [],
    );
  }

  /// `Playlist`
  String get Playlist {
    return Intl.message(
      'Playlist',
      name: 'Playlist',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get Speed {
    return Intl.message(
      'Speed',
      name: 'Speed',
      desc: '',
      args: [],
    );
  }

  /// `Pdf`
  String get Pdf {
    return Intl.message(
      'Pdf',
      name: 'Pdf',
      desc: '',
      args: [],
    );
  }

  /// `Ascending`
  String get Ascending {
    return Intl.message(
      'Ascending',
      name: 'Ascending',
      desc: '',
      args: [],
    );
  }

  /// `Descending`
  String get Descending {
    return Intl.message(
      'Descending',
      name: 'Descending',
      desc: '',
      args: [],
    );
  }

  /// `We're fetching your podcast\nepisodes. Please wait`
  String get FetchingYourPodcast {
    return Intl.message(
      'We\'re fetching your podcast\nepisodes. Please wait',
      name: 'FetchingYourPodcast',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get By {
    return Intl.message(
      'By',
      name: 'By',
      desc: '',
      args: [],
    );
  }

  /// `Please don't press back`
  String get dontPressBack {
    return Intl.message(
      'Please don\'t press back',
      name: 'dontPressBack',
      desc: '',
      args: [],
    );
  }

  /// `Enter Coupon Code`
  String get EnterCouponCode {
    return Intl.message(
      'Enter Coupon Code',
      name: 'EnterCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Available Coupons`
  String get AvailableCoupons {
    return Intl.message(
      'Available Coupons',
      name: 'AvailableCoupons',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get SubTotal {
    return Intl.message(
      'Sub Total',
      name: 'SubTotal',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get Coupon {
    return Intl.message(
      'Coupon',
      name: 'Coupon',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get Remove {
    return Intl.message(
      'Remove',
      name: 'Remove',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Details for VidyaBox Delivery`
  String get DetailsVidyaBox {
    return Intl.message(
      'Details for VidyaBox Delivery',
      name: 'DetailsVidyaBox',
      desc: '',
      args: [],
    );
  }

  /// `Choose Class for VidyaBox`
  String get ChooseClassVidyaBox {
    return Intl.message(
      'Choose Class for VidyaBox',
      name: 'ChooseClassVidyaBox',
      desc: '',
      args: [],
    );
  }

  /// `Choose Medium for VidyaBox`
  String get ChooseMediumVidyaBox {
    return Intl.message(
      'Choose Medium for VidyaBox',
      name: 'ChooseMediumVidyaBox',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get Hindi {
    return Intl.message(
      'Hindi',
      name: 'Hindi',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Add Shipping Address`
  String get AddShippingAddress {
    return Intl.message(
      'Add Shipping Address',
      name: 'AddShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get DeliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'DeliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get ChangeAddress {
    return Intl.message(
      'Change Address',
      name: 'ChangeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Please wait, Fetching plans for you`
  String get PleaseFetchingPlans {
    return Intl.message(
      'Please wait, Fetching plans for you',
      name: 'PleaseFetchingPlans',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Condition Apply`
  String get TermsConditionApply {
    return Intl.message(
      'Terms & Condition Apply',
      name: 'TermsConditionApply',
      desc: '',
      args: [],
    );
  }

  /// `Apply Coupon to get Discount`
  String get ApplyCouponDiscount {
    return Intl.message(
      'Apply Coupon to get Discount',
      name: 'ApplyCouponDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Get Annual Subscription for 365 Days along with VidyaBox Device with 15 days Money Back guarantee`
  String get GetAnnualSubscription {
    return Intl.message(
      'Get Annual Subscription for 365 Days along with VidyaBox Device with 15 days Money Back guarantee',
      name: 'GetAnnualSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Tell me more`
  String get TellMore {
    return Intl.message(
      'Tell me more',
      name: 'TellMore',
      desc: '',
      args: [],
    );
  }

  /// `Please don't close app`
  String get DontCloseApp {
    return Intl.message(
      'Please don\'t close app',
      name: 'DontCloseApp',
      desc: '',
      args: [],
    );
  }

  /// `Plan Active`
  String get PlanActive {
    return Intl.message(
      'Plan Active',
      name: 'PlanActive',
      desc: '',
      args: [],
    );
  }

  /// `Plan Expired`
  String get PlanExpired {
    return Intl.message(
      'Plan Expired',
      name: 'PlanExpired',
      desc: '',
      args: [],
    );
  }

  /// `Expire  `
  String get Expire {
    return Intl.message(
      'Expire  ',
      name: 'Expire',
      desc: '',
      args: [],
    );
  }

  /// `Share statistics`
  String get ShareStatistics {
    return Intl.message(
      'Share statistics',
      name: 'ShareStatistics',
      desc: '',
      args: [],
    );
  }

  /// `This progress shows how many users have installed the app using the link you shared with them`
  String get ProgressMessage {
    return Intl.message(
      'This progress shows how many users have installed the app using the link you shared with them',
      name: 'ProgressMessage',
      desc: '',
      args: [],
    );
  }

  /// `You've bought`
  String get bought {
    return Intl.message(
      'You\'ve bought',
      name: 'bought',
      desc: '',
      args: [],
    );
  }

  /// `install(s) so far`
  String get install {
    return Intl.message(
      'install(s) so far',
      name: 'install',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Now!`
  String get RedeemNow {
    return Intl.message(
      'Redeem Now!',
      name: 'RedeemNow',
      desc: '',
      args: [],
    );
  }

  /// `Premium Plans`
  String get PremiumPlans {
    return Intl.message(
      'Premium Plans',
      name: 'PremiumPlans',
      desc: '',
      args: [],
    );
  }

  /// `Have Reference Code?`
  String get HaveReferenceCode {
    return Intl.message(
      'Have Reference Code?',
      name: 'HaveReferenceCode',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get ShareApp {
    return Intl.message(
      'Share App',
      name: 'ShareApp',
      desc: '',
      args: [],
    );
  }

  /// `Get VidyaBox Trials`
  String get GetVidyaBoxTrials {
    return Intl.message(
      'Get VidyaBox Trials',
      name: 'GetVidyaBoxTrials',
      desc: '',
      args: [],
    );
  }

  /// `Report Bugs / Features`
  String get ReportBugs {
    return Intl.message(
      'Report Bugs / Features',
      name: 'ReportBugs',
      desc: '',
      args: [],
    );
  }

  /// `Rate us / Feedback`
  String get Rateus {
    return Intl.message(
      'Rate us / Feedback',
      name: 'Rateus',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get ContactUs {
    return Intl.message(
      'Contact Us',
      name: 'ContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get Logout {
    return Intl.message(
      'Log out',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Made with' key

  /// ` in India`
  String get inIndia {
    return Intl.message(
      ' in India',
      name: 'inIndia',
      desc: '',
      args: [],
    );
  }

  /// `Welcome aboard!`
  String get WelcomeAboard {
    return Intl.message(
      'Welcome aboard!',
      name: 'WelcomeAboard',
      desc: '',
      args: [],
    );
  }

  /// `We're happy to have you on boarded. You have a `
  String get Weboarded {
    return Intl.message(
      'We\'re happy to have you on boarded. You have a ',
      name: 'Weboarded',
      desc: '',
      args: [],
    );
  }

  /// ` 24 Hours Trial, `
  String get HoursTrial {
    return Intl.message(
      ' 24 Hours Trial, ',
      name: 'HoursTrial',
      desc: '',
      args: [],
    );
  }

  /// `ahead of you!`
  String get aheadYou {
    return Intl.message(
      'ahead of you!',
      name: 'aheadYou',
      desc: '',
      args: [],
    );
  }

  /// `Buy Subscription`
  String get BuySubscription {
    return Intl.message(
      'Buy Subscription',
      name: 'BuySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Share & Get FREE Subscription`
  String get ShareGetFREESubscription {
    return Intl.message(
      'Share & Get FREE Subscription',
      name: 'ShareGetFREESubscription',
      desc: '',
      args: [],
    );
  }

  /// `IBuyLater!`
  String get IBuyLater {
    return Intl.message(
      'IBuyLater!',
      name: 'IBuyLater',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get ChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'ChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get Class {
    return Intl.message(
      'Class',
      name: 'Class',
      desc: '',
      args: [],
    );
  }

  /// `Please submit this survey to help us improve!`
  String get SurvayMesssage {
    return Intl.message(
      'Please submit this survey to help us improve!',
      name: 'SurvayMesssage',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get ChangeTheme {
    return Intl.message(
      'Change Theme',
      name: 'ChangeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Be Ready...`
  String get BeReady {
    return Intl.message(
      'Be Ready...',
      name: 'BeReady',
      desc: '',
      args: [],
    );
  }

  /// `Chapter Test`
  String get ChapterTest {
    return Intl.message(
      'Chapter Test',
      name: 'ChapterTest',
      desc: '',
      args: [],
    );
  }

  /// `Please choose an option, or tap on skip if you don't wanna answer`
  String get Pleasechooseanoption {
    return Intl.message(
      'Please choose an option, or tap on skip if you don\'t wanna answer',
      name: 'Pleasechooseanoption',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get Previous {
    return Intl.message(
      'Previous',
      name: 'Previous',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, Please try again!`
  String get Somethingwentwrong {
    return Intl.message(
      'Something went wrong, Please try again!',
      name: 'Somethingwentwrong',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `Cannot Load Ads, Something went wrong`
  String get CannotLoadAds {
    return Intl.message(
      'Cannot Load Ads, Something went wrong',
      name: 'CannotLoadAds',
      desc: '',
      args: [],
    );
  }

  /// `Test Result`
  String get TestResult {
    return Intl.message(
      'Test Result',
      name: 'TestResult',
      desc: '',
      args: [],
    );
  }

  /// `Review Your Test`
  String get ReviewYourTest {
    return Intl.message(
      'Review Your Test',
      name: 'ReviewYourTest',
      desc: '',
      args: [],
    );
  }

  /// `Your Test Score`
  String get YourTestScore {
    return Intl.message(
      'Your Test Score',
      name: 'YourTestScore',
      desc: '',
      args: [],
    );
  }

  /// `Questions\nAttempted`
  String get QuestionsAttempted {
    return Intl.message(
      'Questions\nAttempted',
      name: 'QuestionsAttempted',
      desc: '',
      args: [],
    );
  }

  /// `Total\nTimeTaken`
  String get TotalTimeTaken {
    return Intl.message(
      'Total\nTimeTaken',
      name: 'TotalTimeTaken',
      desc: '',
      args: [],
    );
  }

  /// `Aur Mehnat Ki Zaroorat hai!`
  String get belowMsg1 {
    return Intl.message(
      'Aur Mehnat Ki Zaroorat hai!',
      name: 'belowMsg1',
      desc: '',
      args: [],
    );
  }

  /// `Mazaa Nhi Aya! Itne Kamm Number?`
  String get belowMsg2 {
    return Intl.message(
      'Mazaa Nhi Aya! Itne Kamm Number?',
      name: 'belowMsg2',
      desc: '',
      args: [],
    );
  }

  /// `Kya Tyaari Ache se Nhi Ki Thhi Kya?`
  String get belowMsg3 {
    return Intl.message(
      'Kya Tyaari Ache se Nhi Ki Thhi Kya?',
      name: 'belowMsg3',
      desc: '',
      args: [],
    );
  }

  /// `Jao Jaake Poora Chapter Dubara Suno SunoKitaab se!`
  String get belowMsg4 {
    return Intl.message(
      'Jao Jaake Poora Chapter Dubara Suno SunoKitaab se!',
      name: 'belowMsg4',
      desc: '',
      args: [],
    );
  }

  /// `Itne Number se Kya Hoga? You need to Keep up!`
  String get belowMsg5 {
    return Intl.message(
      'Itne Number se Kya Hoga? You need to Keep up!',
      name: 'belowMsg5',
      desc: '',
      args: [],
    );
  }

  /// `Theek-Thaak Hi Hai Number, Bahut Zyada Nhi Hai!`
  String get averageMsg1 {
    return Intl.message(
      'Theek-Thaak Hi Hai Number, Bahut Zyada Nhi Hai!',
      name: 'averageMsg1',
      desc: '',
      args: [],
    );
  }

  /// `Hmm, Ok-Ok Report hai!, Not Bad!`
  String get averageMsg2 {
    return Intl.message(
      'Hmm, Ok-Ok Report hai!, Not Bad!',
      name: 'averageMsg2',
      desc: '',
      args: [],
    );
  }

  /// `Well, Bahut Bura Result bhi Nhi Hai Bahut Acha bhi Nhi!`
  String get averageMsg3 {
    return Intl.message(
      'Well, Bahut Bura Result bhi Nhi Hai Bahut Acha bhi Nhi!',
      name: 'averageMsg3',
      desc: '',
      args: [],
    );
  }

  /// `Thoddi Aur Mehnat Ki Hoti to Isse Aur Acha Result aa Skta Thha`
  String get averageMsg4 {
    return Intl.message(
      'Thoddi Aur Mehnat Ki Hoti to Isse Aur Acha Result aa Skta Thha',
      name: 'averageMsg4',
      desc: '',
      args: [],
    );
  }

  /// `Well, This Score means, tumm Isse Zyada Number Araam se Laa Skte ho!`
  String get averageMsg5 {
    return Intl.message(
      'Well, This Score means, tumm Isse Zyada Number Araam se Laa Skte ho!',
      name: 'averageMsg5',
      desc: '',
      args: [],
    );
  }

  /// `Waah re Waah!, Dil Jeet Liya!`
  String get moreMsg1 {
    return Intl.message(
      'Waah re Waah!, Dil Jeet Liya!',
      name: 'moreMsg1',
      desc: '',
      args: [],
    );
  }

  /// `Ye Hui na Kuch Baat! 🎉`
  String get moreMsg2 {
    return Intl.message(
      'Ye Hui na Kuch Baat! 🎉',
      name: 'moreMsg2',
      desc: '',
      args: [],
    );
  }

  /// `Mazaa aa Gya isse Kehte hai SCORE!`
  String get moreMsg3 {
    return Intl.message(
      'Mazaa aa Gya isse Kehte hai SCORE!',
      name: 'moreMsg3',
      desc: '',
      args: [],
    );
  }

  /// `Mehnat ka Fall Meetha Hota hai, Dekhaa!`
  String get moreMsg4 {
    return Intl.message(
      'Mehnat ka Fall Meetha Hota hai, Dekhaa!',
      name: 'moreMsg4',
      desc: '',
      args: [],
    );
  }

  /// `Bass Issi Tareh Lagge Raho Munna Bhai!`
  String get moreMsg5 {
    return Intl.message(
      'Bass Issi Tareh Lagge Raho Munna Bhai!',
      name: 'moreMsg5',
      desc: '',
      args: [],
    );
  }

  /// `Unable to fetch ads at the moment, Please try again later`
  String get UnableToFetch {
    return Intl.message(
      'Unable to fetch ads at the moment, Please try again later',
      name: 'UnableToFetch',
      desc: '',
      args: [],
    );
  }

  /// `New Feature`
  String get NewFeature {
    return Intl.message(
      'New Feature',
      name: 'NewFeature',
      desc: '',
      args: [],
    );
  }

  /// `Single Chapter Test`
  String get SingleChapterTest {
    return Intl.message(
      'Single Chapter Test',
      name: 'SingleChapterTest',
      desc: '',
      args: [],
    );
  }

  /// `We've introduced a brand new feature of assessment which can help you perform better and test your knowledge`
  String get Weintroducedbrandnew {
    return Intl.message(
      'We\'ve introduced a brand new feature of assessment which can help you perform better and test your knowledge',
      name: 'Weintroducedbrandnew',
      desc: '',
      args: [],
    );
  }

  /// `Give test of complete book`
  String get Givetestofcompletebook {
    return Intl.message(
      'Give test of complete book',
      name: 'Givetestofcompletebook',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to give your test?`
  String get Howwouldyoulike {
    return Intl.message(
      'How would you like to give your test?',
      name: 'Howwouldyoulike',
      desc: '',
      args: [],
    );
  }

  /// `With Limited Time`
  String get WithLimitedTime {
    return Intl.message(
      'With Limited Time',
      name: 'WithLimitedTime',
      desc: '',
      args: [],
    );
  }

  /// `Choose the time limit`
  String get Choosethetimelimit {
    return Intl.message(
      'Choose the time limit',
      name: 'Choosethetimelimit',
      desc: '',
      args: [],
    );
  }

  /// `15 Minutes Free Access`
  String get Minutes {
    return Intl.message(
      '15 Minutes Free Access',
      name: 'Minutes',
      desc: '',
      args: [],
    );
  }

  /// `Custom Timing`
  String get CustomTiming {
    return Intl.message(
      'Custom Timing',
      name: 'CustomTiming',
      desc: '',
      args: [],
    );
  }

  /// `Choose number of questions`
  String get Choosenumberofquestions {
    return Intl.message(
      'Choose number of questions',
      name: 'Choosenumberofquestions',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get Questions {
    return Intl.message(
      'Questions',
      name: 'Questions',
      desc: '',
      args: [],
    );
  }

  /// `Before you start,`
  String get Beforeyoustart {
    return Intl.message(
      'Before you start,',
      name: 'Beforeyoustart',
      desc: '',
      args: [],
    );
  }

  /// `Custom exam duration`
  String get Customexamduration {
    return Intl.message(
      'Custom exam duration',
      name: 'Customexamduration',
      desc: '',
      args: [],
    );
  }

  /// `Go!`
  String get Go {
    return Intl.message(
      'Go!',
      name: 'Go',
      desc: '',
      args: [],
    );
  }

  /// `Complete Book Test`
  String get CompleteBookTest {
    return Intl.message(
      'Complete Book Test',
      name: 'CompleteBookTest',
      desc: '',
      args: [],
    );
  }

  /// `Start Test`
  String get StartTest {
    return Intl.message(
      'Start Test',
      name: 'StartTest',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to give your test?`
  String get Howwouldyouliketogiveyourtest {
    return Intl.message(
      'How would you like to give your test?',
      name: 'Howwouldyouliketogiveyourtest',
      desc: '',
      args: [],
    );
  }

  /// `Buy only this chapter for`
  String get Buyonlythischapterfor {
    return Intl.message(
      'Buy only this chapter for',
      name: 'Buyonlythischapterfor',
      desc: '',
      args: [],
    );
  }

  /// `Take a Test`
  String get TakeTest {
    return Intl.message(
      'Take a Test',
      name: 'TakeTest',
      desc: '',
      args: [],
    );
  }

  /// `Prepare for Exams\nwith SunoKitaab`
  String get PrepareforExams {
    return Intl.message(
      'Prepare for Exams\nwith SunoKitaab',
      name: 'PrepareforExams',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get Test {
    return Intl.message(
      'Test',
      name: 'Test',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to give your test?`
  String get Howwouldyouliketogive {
    return Intl.message(
      'How would you like to give your test?',
      name: 'Howwouldyouliketogive',
      desc: '',
      args: [],
    );
  }

  /// `With Unlimited Time`
  String get WithUnlimitedTime {
    return Intl.message(
      'With Unlimited Time',
      name: 'WithUnlimitedTime',
      desc: '',
      args: [],
    );
  }

  /// `Test Ret`
  String get TestRet {
    return Intl.message(
      'Test Ret',
      name: 'TestRet',
      desc: '',
      args: [],
    );
  }

  /// `Image failed to load.`
  String get Imagefailedload {
    return Intl.message(
      'Image failed to load.',
      name: 'Imagefailedload',
      desc: '',
      args: [],
    );
  }

  /// `Media failed to load.`
  String get Mediafailedload {
    return Intl.message(
      'Media failed to load.',
      name: 'Mediafailedload',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get Recommended {
    return Intl.message(
      'Recommended',
      name: 'Recommended',
      desc: '',
      args: [],
    );
  }

  /// `Choose Payment Method`
  String get ChoosePaymentMethod {
    return Intl.message(
      'Choose Payment Method',
      name: 'ChoosePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer`
  String get Disclaimer {
    return Intl.message(
      'Disclaimer',
      name: 'Disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Active Paid Users`
  String get ActivePaidUsers {
    return Intl.message(
      'Active Paid Users',
      name: 'ActivePaidUsers',
      desc: '',
      args: [],
    );
  }

  /// `POPULAR`
  String get POPULAR {
    return Intl.message(
      'POPULAR',
      name: 'POPULAR',
      desc: '',
      args: [],
    );
  }

  /// `Get Access to`
  String get GetAccess {
    return Intl.message(
      'Get Access to',
      name: 'GetAccess',
      desc: '',
      args: [],
    );
  }

  /// `All Audio Books + Audio Lectures + PDFs`
  String get AllAudioBooks {
    return Intl.message(
      'All Audio Books + Audio Lectures + PDFs',
      name: 'AllAudioBooks',
      desc: '',
      args: [],
    );
  }

  /// `All Test Series`
  String get AllTestSeries {
    return Intl.message(
      'All Test Series',
      name: 'AllTestSeries',
      desc: '',
      args: [],
    );
  }

  /// `Download & Listen Offline`
  String get DownloadListenOffline {
    return Intl.message(
      'Download & Listen Offline',
      name: 'DownloadListenOffline',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ads`
  String get RemoveAds {
    return Intl.message(
      'Remove Ads',
      name: 'RemoveAds',
      desc: '',
      args: [],
    );
  }

  /// `Select your subscription`
  String get Selectyoursubscription {
    return Intl.message(
      'Select your subscription',
      name: 'Selectyoursubscription',
      desc: '',
      args: [],
    );
  }

  /// `Books You Bought`
  String get BooksYouBought {
    return Intl.message(
      'Books You Bought',
      name: 'BooksYouBought',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get Favourites {
    return Intl.message(
      'Favourites',
      name: 'Favourites',
      desc: '',
      args: [],
    );
  }

  /// `Exams`
  String get Exams {
    return Intl.message(
      'Exams',
      name: 'Exams',
      desc: '',
      args: [],
    );
  }

  /// `Prepare for Exams\nwith`
  String get PrepareForExam {
    return Intl.message(
      'Prepare for Exams\nwith',
      name: 'PrepareForExam',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Exam`
  String get ChooseYourExam {
    return Intl.message(
      'Choose Your Exam',
      name: 'ChooseYourExam',
      desc: '',
      args: [],
    );
  }

  /// `Test Attempts Left`
  String get TestAttemptsLeft {
    return Intl.message(
      'Test Attempts Left',
      name: 'TestAttemptsLeft',
      desc: '',
      args: [],
    );
  }

  /// `Buy Premium to Unlock Unlimited Attempts`
  String get BuyPremiumUnlock {
    return Intl.message(
      'Buy Premium to Unlock Unlimited Attempts',
      name: 'BuyPremiumUnlock',
      desc: '',
      args: [],
    );
  }

  /// `We've introduced a brand new feature of assessment which can help you perform better and test your knowledge`
  String get WeIntroduced {
    return Intl.message(
      'We\'ve introduced a brand new feature of assessment which can help you perform better and test your knowledge',
      name: 'WeIntroduced',
      desc: '',
      args: [],
    );
  }

  /// `1 Hour Free Access`
  String get OneHour {
    return Intl.message(
      '1 Hour Free Access',
      name: 'OneHour',
      desc: '',
      args: [],
    );
  }

  /// `Time left to access the entire app`
  String get TimeLeftTo {
    return Intl.message(
      'Time left to access the entire app',
      name: 'TimeLeftTo',
      desc: '',
      args: [],
    );
  }

  /// `Your today's free trial qouta is expired please upgrade or wait for next day`
  String get YourToday {
    return Intl.message(
      'Your today\'s free trial qouta is expired please upgrade or wait for next day',
      name: 'YourToday',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get Upgrade {
    return Intl.message(
      'Upgrade',
      name: 'Upgrade',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'or'),
      Locale.fromSubtags(languageCode: 'pa'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
