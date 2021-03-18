//USE FOR API URL
const BASE_URL = '';
const LOGIN_URL = '$BASE_URL//';
const FORGOT_PASSWORD_URL = '$BASE_URL//';
const CHANGE_PASSWORD_URL = '$BASE_URL//';
const PROFILE_EDIT_URL = '$BASE_URL//';
const PENDING_URL = '$BASE_URL//';
const ACCEPTED_URL = '$BASE_URL//';
const READY_URL = '$BASE_URL//';
const DISPATCHED_URL = '$BASE_URL//';
const ACCEPT_URL = '$BASE_URL//';
const REJECT_URL = '$BASE_URL//';
const FOOD_READY_URL = '$BASE_URL//';
const DISPATCH_URL = '$BASE_URL//';
const SETTLE_ORDER_URL = '$BASE_URL//';
const ALL_FIND_URL = '$BASE_URL//';
const PAUSE_MENU_URL = '$BASE_URL//';
const TURN_OF_ORDERING_URL = '$BASE_URL//';
const PAST_ORDER_URL = '$BASE_URL//';
const NEW_ORDER_URL = '$BASE_URL//';
const KDS_VIEW_URL = '$BASE_URL//';
const PROFILE_URL = '$BASE_URL//';

//USE FOR FIREBASE TABLE NAME
const tableNameNotificationCounter = 'notificationcounter';

//USE FOR LOCAL STORAGE
const SECURE_STORAGE_USERNAME = "username";
const SECURE_STORAGE_EMAIL = "email";
const SECURE_STORAGE_MOBILE = "mobile";
const SECURE_STORAGE_PROFILE_URL = "profileURL";
const SECURE_STORAGE_USER_ID = "userId";
const SECURE_STORAGE_TOKEN = "token";
const SECURE_STORAGE_PINCODE = "pinCode";
const SECURE_STORAGE_ADDRESS = "address";
const SECURE_STORAGE_WHERE_LOGIN = "login";
const SECURE_STORAGE_ON_BOARDING = "onBoarding";
const SECURE_STORAGE_FIREBASE_TOKEN = "firebaseToken";

//USE FOR WHICH TYPE OF LOGIN
const WHERE_LOGIN = "login";
const WHERE_FACEBOOK_LOGIN = "facebook";
const WHERE_GOOGLE_LOGIN = "google";

const ON_BOARDING = "true";

//USE FOR ORDER STATUS
const whereToReachOrderPending = 1;
const whereToReachOrderAccepted = 2;
const whereToReachOrderReady = 3;
const whereToReachOrderDispatched = 4;

//USE FOR VEGITABLE ICON
const vegIcon = 1;
const nonVegIcon = 2;
