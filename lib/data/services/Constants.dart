import '../../language.dart';

class Constants {
  // static String get baseURL => "http://20.197.7.132:3000";
  // static String get baseURL => "https://sunokitaab.grevity.in/api";
  static String get baseURL => "https://s0.sunokitaab.com/api";
  // static String get baseURL => "http://192.168.187.240:3000/api";
  // static String get baseURL => "https://dev.sunokitaab.com";
  // static String get baseURL => "https://sunokitaab.herokuapp.com";
  // static String get baseURL => "http://10.0.2.2:3000";
  // static String get baseURL => "https://f5c2-103-95-164-40.in.ngrok.io";

  static int get versionCode => 167;
  static String get versionName => "1.10.37";
  static String get appUrl => "https://sunokitaab.com/app";
  static String get mqttUrl => "20.193.159.229";
  static int get mqttPort => 1884;
  static String get mqttTopic => "sunokitaab/analytics";
  static String dataDirectory = "/data/data/com.sunokitaab.sunokitaab";
  // static String get razorpayKey => "rzp_live_eC5510NrqVzWpY";
  static String get wiredashProjectId => "sunokitaab-a5n659a";
  static String get wiredashKey => "eitpyUJ476ISN5GQUpzcS4D90j9PJ1a_";
  static String get paytmMid => "xSbAIq08176873646306";
  static int get chapterTestPopupCount => 4;
  static int get coreTestPopupCount => 4;
  static int get bookTestPopupCount => 4;
  // static String get paytmCallbackUrl => "https://9208-103-95-164-134.in.ngrok.io/shared/paytm.callback";
  // static String get paytmCallbackUrlForBooks => "https://4230-103-95-164-135.in.ngrok.io/shared/books.paytm.callback";
  static bool get paytmIsStaging => false;
  static String get razorpayKey => "rzp_live_eC5510NrqVzWpY";
  // static String get razorpayKey => "rzp_test_tOtnhA60T5owPX";
  static String get mobileNumber => "9799166556";

  static String get stripeKey => "pk_live_51MH3S1SBiQviRKrIamh6BwA1bYuxsMzjQ3LK8HcleOcUxB2TMGQVlAv4QhvxdxTLzcFPvpDJ9rGgCSl9PqPLBnY700prpykQPB";
  static String get androidUnitId => "ca-app-pub-2816729475725512/8556341042";
  static String get iosUnitId => "ca-app-pub-2816729475725512/7962266488";
}

class Version1 {
  //Auth Urls...
  String verifyPhone({bool forcefully = false}) => "${Constants.baseURL}/user/verify.phone${forcefully ? ".forcefully" : ""}";
  String verifyOtp(String phone, String otp) => "${Constants.baseURL}/user/verify.otp/$phone/$otp";
  String get register => "${Constants.baseURL}/user";
  String get validate => "${Constants.baseURL}/user/validate";
  String get login => "${Constants.baseURL}/user/login";
  String doExist(String phone) => "${Constants.baseURL}/user/exists/$phone";
  String get authWithTruecaller => "${Constants.baseURL}/user/truecaller.user";

  //Public Urls..
  String get getClasses => "${Constants.baseURL}/shared/class";
  String get getClassesWithMeta => "${Constants.baseURL}/shared/class.meta";
  String get getCategoriesWithMeta => "${Constants.baseURL}/shared/categories.meta";
  String get governmentBooksCategory => "${Constants.baseURL}/content/v2.book_category.active/3";
  String get getUGBooksCategory => "${Constants.baseURL}/content/v2.book_category.active/4";
  String get getRankedBooks => "${Constants.baseURL}/shared/book_by_rank";
  String get getStates => "${Constants.baseURL}/shared/state";
  String getDistricts(int state) => "${Constants.baseURL}/shared/district/$state";
  String getBookDetails(int book) => "${Constants.baseURL}/content/book_details/$book";
  String getBooksByClass(int classId) => "${Constants.baseURL}/content/class.books/$classId";
  String get beyondAcademicBooks => "${Constants.baseURL}/content/v2.book_summaries";
  String governmentBooks(int category) => "${Constants.baseURL}/content/v3.goverment_exams/$category";
  String getUGBooks(int category) => "${Constants.baseURL}/content/ug_book/$category";
  String get governmentBooksV4 => "${Constants.baseURL}/content/v4.goverment_exams";
  String getChaptersByBook(int bookId) => "${Constants.baseURL}/content/book.chapters.v2/$bookId";
  String get products => "${Constants.baseURL}/shared/products";
  String getShareLink(int userId) => "${Constants.baseURL}/user/link/$userId";
  String updateShareLink(int userId) => "${Constants.baseURL}/user/link.update/$userId";
  String searchChapter(String keyword) => "${Constants.baseURL}/shared/search/$keyword";
  String searchBook(String keyword) => "${Constants.baseURL}/content/find_book/$keyword";
  String podcasts(int after) => "${Constants.baseURL}/content/podcasts/$after";
  String getSchools(String query, int states) => "${Constants.baseURL}/shared/school.query/$query/$states";
  String get uploadUrl => "${Constants.baseURL}/creator/upload_url";
  String get schoolDetails => "${Constants.baseURL}/shared/school_details";
  String verifyReferenceCode(String code) => "${Constants.baseURL}/shared/reference_code/$code";
  String get heatmap => "${Constants.baseURL}/stats/heatmap";
  String get boards => "${Constants.baseURL}/stats/boards";
  String getSurvey(int user) => "${Constants.baseURL}/shared/survey.latest/$user";
  String get submitSurvey => "${Constants.baseURL}/shared/survey.submission";
  String get videoFeed => "${Constants.baseURL}/shared/video_feed";
  String get leadEvent => "${Constants.baseURL}/shared/lead_event";

  //Library Urls...
  String getLibrary(int user, int offset) => "${Constants.baseURL}/user/library.user/$user/$offset";
  String get saveToLibrary => "${Constants.baseURL}/user/library";
  String removeFromLibrary(int id) => "${Constants.baseURL}/user/library/$id";

  //User Urls...
  String get createSubscription => "${Constants.baseURL}/user/payment";
  String get buyBooks => "${Constants.baseURL}/user/cart.buy";
  String fetchSubscriptions(String createdAt) => "${Constants.baseURL}/shared/v4.subscription_for_user/$createdAt/${Constants.versionCode}";
  String getSubscription(int user) => "${Constants.baseURL}/user/subscription/$user";
  String getBooksInCart(int user) => "${Constants.baseURL}/user/cart/$user";
  String get pushDynamicData => "${Constants.baseURL}/user/incr.download";
  String getLinkStats(String linkCode) => "${Constants.baseURL}/user/link.stats/$linkCode";
  String get saveTempUser => "${Constants.baseURL}/user/temp";
  String get addBookToCart => "${Constants.baseURL}/user/cart";
  String removeBookFromCart(int user, int book) => "${Constants.baseURL}/user/cart/$user/$book";
  String get ping => "${Constants.baseURL}/user/ping";
  String get createRazorpayOrder => "${Constants.baseURL}/shared/createOrder.razorpay";
  String get rzpCreateSubscriptionOrder => "${Constants.baseURL}/shared/razorpay.createSubscriptionOrder";
  String get createRazorpayOrderForBook => "${Constants.baseURL}/shared/createChapterOrder.razorpay";
  String get vbDemo => "${Constants.baseURL}/shared/vb_demo";
  String get createPaytmOrder => "${Constants.baseURL}/shared/createOrder.paytm";
  String get createPaytmOrderForBooks => "${Constants.baseURL}/shared/createBooksOrder.paytm";
  String get createPaytmChapterOrder => "${Constants.baseURL}/shared/createChapterOrder.paytm";
  String getUserChapter(int chapter, int user) => "${Constants.baseURL}/shared/user_chapter/$chapter/$user";
  String podcastEpisodesBought(int podcast, int podcastIndex) => "${Constants.baseURL}/shared/user_podcast/$podcast/$podcastIndex";
  String get postComment => "${Constants.baseURL}/user/comment";
  String get postRating => "${Constants.baseURL}/content/rating";
  String fetchComments(int lectureId) => "${Constants.baseURL}/user/comment/$lectureId";
  String get saveAddress => "${Constants.baseURL}/user/address";
  String get updateUser => "${Constants.baseURL}/user";
  String deleteAccount(int user) => "${Constants.baseURL}/user/$user";
  String isAccountAlive(int user) => "${Constants.baseURL}/user/is_alive/$user";

  //Event Urls...
  String get fetchNewEvents => "${Constants.baseURL}/content/events.new";
  String fetchEventsByAuthor(int authorId) => "${Constants.baseURL}/content/author.events/$authorId";
  String getToken(int id) => "${Constants.baseURL}/content/event.token/$id";
  String updateStatus(int eventCode, int statusCode) => "${Constants.baseURL}/content/event/$eventCode/$statusCode";
  String get createEvent => "${Constants.baseURL}/content/event";
  String countInEvent(int user, int event) => "${Constants.baseURL}/content/event.count_user/$user/$event";

  //Stats Urls...
  String buttonEvents(userId, eventId) => "${Constants.baseURL}/stats/button/$eventId/$userId";
  String get feedback => "${Constants.baseURL}/stats/feedback";
  String get chapterUnlockFromAd => "${Constants.baseURL}/shared/chapter_unlocked_by_ad";
  String get updateChapterUnlockFromAd => "${Constants.baseURL}/shared/update.chapter_unlocked_by_ad";

  //Job Urls..
  String get fetchJobs => "${Constants.baseURL}/rms/jobs/0";
  String get applyToJob => "${Constants.baseURL}/rms/apply";
  String get updateAnswerForJob => "${Constants.baseURL}/rms/apply.answers";
  String get createApplication => "${Constants.baseURL}/rms/application.create";

  //Config Urls..
  String get checkForUpdates => "${Constants.baseURL}/shared.config/legacy.checkForUpdates";
  String getSettings(String keyId) => "${Constants.baseURL}/shared/setting.value/$keyId";
  String getSettingValues(String keyId) => "${Constants.baseURL}/shared/setting.values/$keyId";
  String getSettingsByType(int typeId) => "${Constants.baseURL}/shared/setting.type/$typeId";
  String getCacheValue(String key) => "${Constants.baseURL}/shared.config/cache/$key";

  //Other Urls...
  String get reportCrash => "${Constants.baseURL}/legacy.crash";
  String getTrialStartDate(int user) => "${Constants.baseURL}/shared/trial_start_date/$user";
  String getReferenceCodeDetails(String code) => "${Constants.baseURL}/shared/reference_code/$code";
  String getTrialStartDateV2(int user) => "${Constants.baseURL}/shared/trial_start_date.v2/$user";
  String get coupon => "${Constants.baseURL}/shared/coupons.active";
  String get validateCoupon => "${Constants.baseURL}/shared/v2.validate.coupon";
  String get schoolOnBoard => "${Constants.baseURL}/shared/onboard_school_for_vidyabox";
  String get savePhoneNumbers => "${Constants.baseURL}/shared/save_phone_numbers";
  String get randomSubscribers => "${Constants.baseURL}/shared/random_subscribers_data";
  String get trialDetails => "${Constants.baseURL}/user/trial";
  String get referralAssets => "${Constants.baseURL}/user/generate_referal_link";
  String get updateTrialConsumption => "${Constants.baseURL}/user/trial.update_consumption";
  String getFreeBookOfTheDay(String day) => "${Constants.baseURL}/shared/free_book.current/$day";
  String get gatewaysForChapter => "${Constants.baseURL}/shared/payment_gateways_for_chapters";
  String get bookRequest => "${Constants.baseURL}/shared/request_book";
  String get sendTelegramMessage => "${Constants.baseURL}/shared/telegram.message";
  String get sendVBTelegramMessage => "${Constants.baseURL}/shared/telegram.message.vb_events";
  String get sendTelegramMessageVideoEvents => "${Constants.baseURL}/shared/telegram.message.video_events";
  String get sendTelegramMessagePremiumScreen => "${Constants.baseURL}/shared/telegram.message.premium_screen";
  String get getPreSignedUrl => "${Constants.baseURL}/shared/s3.preSignedUrl";
  String get teacherAndSchoolForm => "${Constants.baseURL}/user/teacher_and_school_form";

  //Assessment Urls....
  String availableQBankForChapter(int chapter) => "${Constants.baseURL}/content/available_questions_for_chapter/$chapter";
  String getQuestionCountInBook(int book) => "${Constants.baseURL}/content/question_count_in_book/$book";
  String chapterQuestions(int chapter, int limit) => "${Constants.baseURL}/content/create_question_paper.chapter/$chapter/$limit";
  String bookQuestions(int book, int chapter, int limit) => "${Constants.baseURL}/content/create_question_paper.book/$book/$chapter/$limit";
  String coreExamQuestions(int exam, int limit) => "${Constants.baseURL}/content/create_question_paper/$exam/$limit";
  String get saveExamResponse => "${Constants.baseURL}/content/exam_response";
  String getActiveExam(int id) => "${Constants.baseURL}/content/exam.active/$id";
  String get getExamCategory => "${Constants.baseURL}/content/exam.category.active";
  String getExamTrialDetails(int user) => "${Constants.baseURL}/content/exam_trial/$user";
  String decreaseExamTrial(int user) => "${Constants.baseURL}/content/exam_trail.decrease/$user";

  //Shop Urls...
  String get listShopProducts => "${Constants.baseURL}/shop/list";
  String listCart(int user) => "${Constants.baseURL}/shop/cart/${user}";
  String get addToCart => "${Constants.baseURL}/shop/cart.add_item";
  String get removeFromCart => "${Constants.baseURL}/shop/cart.remove_item";
  String get updateQty => "${Constants.baseURL}/shop/update_qty";
  String get cartCheckout => "${Constants.baseURL}/shared/telegram.cart_checkout";

  //Ads url...
  String get customAudioAds => "${Constants.baseURL}/shared/custom_audio_ads";
  String get customVideoAds => "${Constants.baseURL}/shared/custom_video_ads";

  // ChatRoom url..
  String get createChatRoom => "${Constants.baseURL}/shared/ai_chat_room";
  String chatRooms(String userID) => "${Constants.baseURL}/shared/user.ai_chat_rooms/$userID";
  String chatRoomMessages(String roomId) => "${Constants.baseURL}/shared/ai_chat_room.chats/$roomId";

  String deleteChatRoom(String roomId) => "${Constants.baseURL}/shared/ai_chat_room/$roomId";

  String get saveChatRoomMessage => "${Constants.baseURL}/shared/ai_chat_room.chat";

  // order shipping
  String get shippingAddress => "${Constants.baseURL}/shared/save_shipping_address";
  String get vidyaboxSlides => "${Constants.baseURL}/shared/get_vb_slides";

}

List<ChooseLangModel> languageList = [
  ChooseLangModel(langHint: "English", mainText: "Hello", langCode: "en"),
  ChooseLangModel(langHint: "Hindi", mainText: "नमस्ते", langCode: "hi"),
  ChooseLangModel(langHint: "Punjabi", mainText: "ਸਤ ਸ੍ਰੀ ਅਕਾਲ", langCode: 'pa'),
  ChooseLangModel(langHint: "Bangla", mainText: "হ্যালো", langCode: "bn"),
  ChooseLangModel(langHint: "Gujarati", mainText: "નમસ્તે", langCode: "gu"),
  ChooseLangModel(langHint: "Kannada", mainText: "ನಮಸ್ಕಾರ", langCode: "kn"),
  ChooseLangModel(langHint: "Malayalam", mainText: "ഹലോ", langCode: "ml"),
  ChooseLangModel(langHint: "Marathi", mainText: "नमस्कार", langCode: "mr"),
  ChooseLangModel(langHint: "Oriya", mainText: "ନମସ୍କାର", langCode: "or"),
  ChooseLangModel(langHint: "Telugu", mainText: "హలో", langCode: "te"),
  ChooseLangModel(langHint: "Tamil", mainText: "வணக்கம்", langCode: 'ta')
];

class ApiConstants {
  static Version1 get version1 => Version1();
}

///Stats Constants
class ButtonEvents {
  static int get FEEDBACK_AND_SUGGESTION => 0;
}

class SettingsValue {
  static int get EXPLORE_SCREEN_TEXT => 0;
  static String get DOWNLOADS_REQUIRED_TO_REDEEM => "DOWNLOADS_TO_REDEEM";
}

class StringConst {
  static const String exam = "Exams";
}
