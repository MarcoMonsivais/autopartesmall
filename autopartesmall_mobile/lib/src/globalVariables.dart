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

bool isAdmin = false;

String textSearch = '';

String SK_STRIPE='',PK_STRIPE='',STRIPE_MERCHANTID='',STRIPE_ANDROIDPAYMODE;

class user {

  String userMail;
  String userPass;
  String userName;
  String userLastName;
  String userPhoneNumber;

  user({
    this.userMail,
    this.userPass,
    this.userName,
    this.userLastName,
    this.userPhoneNumber,
  });

}

class infoUser{

  String uuidUser;
  String mailUser;
  String passUser;

  infoUser({
    this.uuidUser,
    this.mailUser,
    this.passUser,
  });

}

class infoPayment{
  String methodId;
  String intentId;
  String currency;
  String amount;
  String description;

  infoPayment({
    this.methodId,
    this.intentId,
    this.currency,
    this.amount,
    this.description
  });
}

class keyConf {
  String SK_STRIPE_GLOBAL;
  String PK_STRIPE;
  String STRIPE_MERCHANTID;
  String STRIPE_ANDROIDPAYMODE;

  keyConf({
    this.PK_STRIPE,
    this.SK_STRIPE_GLOBAL,
    this.STRIPE_MERCHANTID,
    this.STRIPE_ANDROIDPAYMODE,
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
    this.pname,
    this.pprice,
    this.pid,
    this.pimg,
    this.prate,
    this.pstore,
    this.pparte,
  });


}