var express = require('express');
var router = express.Router();
var URL = require('url');
var User = require('./user');

// 返回对象
router.get('/getUserInfo', function(req, res, next) {

    var user = new User();
    var params = URL.parse(req.url, true).query;

 if(params.id == '1') {

    user.name = "罗子君";
    user.age = "37";
    user.city = "上海市";

}else{    
    user.name = "贺函";
    user.age = "36";
    user.city = "上海市";
}

  var response = {status:1,data:user};
  res.send(JSON.stringify(response));

});

// 返回简单的 JSON
router.get('/getAll', function(req, res, next) {

  var data = {
    "靳东":"贺涵", "马伊琍":"罗子君", "袁泉":"唐晶", "雷佳音":"陈俊生 ", "吴越":"凌玲", "许娣":"薛甄珠", "张龄心":"罗子群", "邬君梅":"吴大娘", "栾元晖":"白光", "郑罗茜":"薇薇安", "啜妮":"洛洛", "梅婷":"卓渐清前女友", "谭凯":"Adom", "孔维":"单身女人", "张棪琰":"苏曼殊", "侯岩松":"老金", "魏之皓":"平儿", "王天泽":"冷佳清", "于明加":"安琪儿CEO", "任东霖":"李睿", "张衣":"罗平", "黄澜":"M女士", "陈道明":"卓渐清"
  }

  var response = {status:1,data:data};
  res.send(JSON.stringify(response));

});

/* GET users listing. */
/*router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});*/

module.exports = router;
