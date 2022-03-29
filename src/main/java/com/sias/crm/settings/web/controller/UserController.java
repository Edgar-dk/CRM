package com.sias.crm.settings.web.controller;

import com.sias.crm.commons.domain.ReturnObject;
import com.sias.crm.settings.domain.User;
import com.sias.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * @author Edgar
 * @create 2022-03-28 21:15
 * @faction:
 */

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/settings/qx/user/login")
    public String HelloController(){
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login")
    /*把从数据库中返回过来的数据按照json的形式返回,这个返回的对象
    * 现在还不知道是什么，所以在返回的位置上写一个Object即可，代表的意思是
    * 返回一个Object这个类*/
    @ResponseBody
    public Object login(String loginAct , String longinPwd , String isRemPwd, HttpServletRequest request){
        /*01.传递过来的数据封装成一个Map对象*/
        HashMap<Object, Object> map = new HashMap<>();
        map.put("loginAct",loginAct);
        map.put("longinPwd", longinPwd);
        /*02.把页面传递过来的数据放在这里传递和数据库中的数据对比
        *    这个对比的过程是一个for循环语句，因为你要去判断各种
        *    可能产生的原因，以及处理完这些基本的原因后，在干什么
        *
        * 注意：这里有一个需要加深理解的地方，先传递参数，然后从数据库
        *      从数据库中获取的数据，按照对象的形式封装，在一层一层的方式过来，
        *      所谓的一层一层的，因为在传递参数的前面有返回的类型，按着这个类型返回,
        *      按照这个类型过来的数据也要判断里面有没有值，以及是否发生错误   */
        User user2 = userService.queryUserByLoginActAndPwd(map);

        ReturnObject object = new ReturnObject();
        if(user2==null){
            /*03.密码和账户不想等*/
            object.setCode("0");
            object.setMessage("用户名或者是密码错误");
        }else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            /*04.把当前的时间转换成字符串的形式*/
            String format = sdf.format(new Date());
            /*05.format就是当前时间的字符串形式，然后在和User中的时间比较
            *    比较两者的大小，*/
            if(format.compareTo(user2.getExpireTime())>0){
                object.setCode("0");
                object.setMessage("账号过期");
            }else if("0".equals(user2.getLockState())){
                /*06.这一步是对比，0是否和用户中的账户状态一样
                *    0的话，表示一个状态，1的话，表示一个状态*/
                object.setCode("0");
                object.setMessage("账号被锁定");
            }else if(!user2.getAllowIps().contains(request.getRemoteAddr())){
                /*07.通过用户发送过来的前段数据，判读，数据库中的ip
                *    是否和用户当前使用的IP一致,上面的是判断用户当前使用
                *    的IP是否在数据库中的IP中*/
                object.setCode("0");
                object.setMessage("IP错误");
            }else {
                /*08.上面的条件满足完之后才表示登陆成功*/
                object.setCode("1");
            }
        }
        return object;
    }
}
