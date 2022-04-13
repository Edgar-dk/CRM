package com.sias.crm.workbench.web.controller;

import com.sias.crm.commons.constans.Constant;
import com.sias.crm.commons.domain.ReturnObject;
import com.sias.crm.commons.utils.DataUtils;
import com.sias.crm.commons.utils.UUIDUtils;
import com.sias.crm.settings.domain.User;
import com.sias.crm.settings.service.UserService;
import com.sias.crm.workbench.domain.Activity;
import com.sias.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author Edgar
 * @create 2022-04-03 18:44
 * @faction:
 */

@Controller
public class ActivityController {

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    /*1.查询全部的数据
    *   点击一个页面把数据展示在页面上*/
    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request){

        /*01.前面的是返回的数据
        *    前面的user是查询出来的数据
        *    虽然说查询出来了，是放在了实体类中
        *    但是没有放在页面上去展示，这个所谓的展示过程
        *    是，从页面上获取实体类中的字段，然后显示
        *    在上面*/
        List<User> users = userService.queryAllUser();
        /*02.把得到的数据放到作用域中
        *    然后页面去数据的时候，在从作用域中取出来*/
        request.setAttribute("users",users);
        return "workbench/activity/index";
    }



    /*2.增加用户的信息（页面增加数据）
    *   idea在去接收数据，通过一定的方式处理之后，在存到数据库中*/
    @RequestMapping("/workbench/activity/saveCreateActivity.do")
    @ResponseBody
    public Object saveCreateActivity(Activity activity, HttpSession session){
        /*分析：在传递参数的时候，浏览器上的数据段是很多的，在idea中用变量
        *      来接收数据的话，写在参数中，是一件非常繁琐的事情，所以可以把
        *      页面传递过来的数据封装成一个对象传递，但是浏览器和idea中，Mapper层
        *      的变量不对应的，浏览器上的变量少了2个，一个是时间，这个时间的话，
        *      没有办法从浏览器上传递过来，但是可以在idea中，把缺少的数据放到
        *      传递参数的对象中*/

        User user=(User) session.getAttribute(Constant.SESSION_USER);
        /*1.给浏览器过来的数据，产生一个uuid*/
        activity.setId(UUIDUtils.getUUid());
        activity.setCreateTime(DataUtils.formateDateTime(new Date()));
        /*2.这个是谁创建的数据，为什么不使用名字
        *   因为，在以后的业务中，可能会发生改变，最好使用id的形式去
        *   增加用户的信息*/
        activity.setCreateBy(user.getId());




        /*3。向数据库中增加数据
        *    这个增加数据的过程，是需要判断数据是否加入成功,怎么去判断这个数据
        *    是否加入成功的，需要ReturnObject这个类去判断，用这个类去设置一个值
        *    去返回一个，成功或者是失败的标志。还有在加入数据的过程，也是需要判断的
        *    ，一旦哪一个地方出现了错误，就不会提交数据，然后把错误的信息返回给浏览器*/
        ReturnObject returnObject = new ReturnObject();
        try {
            int ret = activityService.saveCreateActivity(activity);
            if (ret>0){
                returnObject.setCode(Constant.ReTURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Constant.ReTURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙，正在加载中");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Constant.ReTURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙，正在加载中");
        }


        /*4.这个对象里面已经设置了数据，只需要把这个数据放回到访问这个地址的子页面
        *   然后子页面获取里面的数据，根据里面的标志来判断成功于否*/
        return returnObject;
    }



    /*3.查询activity表中的总条数*/
    @RequestMapping("/workbench/activity/queryActivityByConditionForPage.do")
    public @ResponseBody Object queryActivityByConditionForPage(String name,String owner,
                                                  String startDate,String endDate,
                                                  int pageNo,int pageSize){
        /*01.页面过来的数据，放在map中去接收*/
        HashMap<Object, Object> map = new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("beginNo",(pageNo-1)*pageSize);
        map.put("pageSize",pageSize);
        List<Activity> activityList = activityService.queryActivityByConditionForPage(map);
        int totalRows = activityService.queryActivityOfByCondition(map);

        /*02.从数据库中查出来的数据，放在map中，最后返回的时候，转成
        *    json字符串*/
        HashMap<Object, Object> retMap = new HashMap<>();
        retMap.put("activityList",activityList);
        retMap.put("totalRows",totalRows);
        return retMap;
    }
}
