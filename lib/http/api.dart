class Api {

  /// 首页(推荐)-文章列表  page初始为0
  static String recommend(int page) {
    return "https://www.wanandroid.com/article/list/$page/json";
  }

  /// 首页(广场)
  /// GET请求
  /// 页码拼接在url上 page初始为0
  static String square(int page){
    return "https://wanandroid.com/user_article/list/$page/json";
  }

  /// 首页(问答)
  /// GET请求
  /// 页码拼接在url上 page初始为0
  static String question(int page){
    return "https://wanandroid.com/wenda/list/$page/json";
  }

  /// 首页 Banner
  static String banner = "https://www.wanandroid.com/banner/json";

  /// 妹纸列表   page初始为1
  static String girlUrl(int page, {int count = 10}) {
    return "https://gank.io/api/v2/data/category/Girl/type/Girl/page/$page/count/$count";
  }

  /// 登录
  /// 方法：POST
  /// 参数：username，password
  /// 登录后会在cookie中返回账号密码，只要在客户端做cookie持久化存储即可自动登录验证。
  static String login = "https://www.wanandroid.com/user/login";

  /// 注册
  /// 方法：POST
  /// 参数：username，password,repassword
  static String register = "https://www.wanandroid.com/user/register";

  /// 退出
  /// 方法：GET
  /// 访问了 logout 后，服务端会让客户端清除 Cookie（即cookie max-Age=0），
  /// 如果客户端 Cookie 实现合理，可以实现自动清理，如果本地做了用户账号密码和保存，及时清理
  static String logout = "https://www.wanandroid.com/user/logout/json";

}
