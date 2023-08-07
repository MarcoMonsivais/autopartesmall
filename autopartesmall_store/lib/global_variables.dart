library global;

String userid='',
    username = '',
    useremail = '',
    userRFC='',
    usertelephone='',
    useraddressstreet='',
    useraddressnumber='',
    useraddresscol='',
    useraddresscity='',
    useraddressedo='',
    usercarnumber='',
    usercustomerid='',
    usertype='',
    userprofileid='',
    pagoid = '',
    register = '';

String textSearch = '';

bool logged = false;

String SK_STRIPE='sk_test_51JDmfWACFA40i9cplDBQ410LseMTz7cR24G7dHNUAC886feIScViSRtQ0CYs8Q5I8n2AwzSOOBMTV0KwwUlP5yTJ00Omvac8af',
    PK_STRIPE='pk_test_51JDmfWACFA40i9cpFuoHjoa1lTygoQ5pL3Yc0BATjiLcsIeUgWbDBMcIgz1glXDvNBjXlGUIJVG5hA6fYiQg6HB500Wn1P0yg5',
    STRIPE_MERCHANTID='autopartesMall',
    STRIPE_ANDROIDPAYMODE='autopartesMall';

class User {

  String userMail;
  String userPass;
  String userName;
  String userLastName;
  String userPhoneNumber;

  User({
    required this.userMail,
    required this.userPass,
    required this.userName,
    required this.userLastName,
    required this.userPhoneNumber,
  });

}

class InfoUser{

  String uuidUser;
  String mailUser;
  String passUser;

  InfoUser({
    required this.uuidUser,
    required this.mailUser,
    required this.passUser,
  });

}

class InfoPayment{
  String methodId;
  String intentId;
  String currency;
  String amount;
  String description;

  InfoPayment({
    required this.methodId,
    required this.intentId,
    required this.currency,
    required this.amount,
    required this.description
  });
}

class KeyConf {
  String SK_STRIPE_GLOBAL;
  String PK_STRIPE;
  String STRIPE_MERCHANTID;
  String STRIPE_ANDROIDPAYMODE;

  KeyConf({
    required this.PK_STRIPE,
    required this.SK_STRIPE_GLOBAL,
    required this.STRIPE_MERCHANTID,
    required this.STRIPE_ANDROIDPAYMODE,
  });

}

class Product {

  String pname;
  String pprice;
  String pid;
  String pimg;
  String prate;
  String pstore;
  String pparte;

  Product({
    required this.pname,
    required this.pprice,
    required this.pid,
    required this.pimg,
    required this.prate,
    required this.pstore,
    required this.pparte,
  });


}