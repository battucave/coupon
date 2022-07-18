class ApiRoutes {
  ///All api endpoint
  static const apiHost = "http://18.222.199.244/";
  ///Auth
  static const register = "api/v1/auth/register";
  static const login = "api/v1/auth/login";
  static const forgotPasswordOtp = "api/v1/auth/forgot-password/opt";
  static const verifyOtp = "api/v1/otp/verify";
  static const resetPassword = "api/v1/auth/reset-password?reset_password_token=";
  static const sendMailOtp = "api/v1/otp/send?type=Email";
  ///Profile
  static const profile = "api/v1/user/profile";
  static const logout = "api/v1/user/logout";
  static const uploadImage = "api/v1/category/upload-profile-image";
  static const getProfileImage = "api/v1/user/get-profile-image";
  ///Category
  static const allCategory = "api/v1/category/all/";
  static const subCategory = "sub_categories/all";
  ///Coupon
  static const allCoupon = "api/v1/coupons/all/";
  static const couponByVendorId = "coupons/all";
  static const claimCoupon = "api/v1/apps/claim/";
  static const expiredCoupon = "api/v1/coupons/expired/all/";
  static const featuredCoupon = "api/v1/coupons/featured/all/";
  static const claimCouponList = "api/v1/apps/coupon/claimed/";
  static const subCatCouponList = "api/v1/apps/coupons/all/";
  static const featuredCouponApps = "api/v1/apps/coupons/featured/all/apps";
  static const couponById = "/api/v1/coupon/";



  ///Vendor
  static const vendor = "vendors/all/";
  static const vendorById = "api/v1/vendor/";
  static const allVendor = "api/v1/vendor/all/";

}
