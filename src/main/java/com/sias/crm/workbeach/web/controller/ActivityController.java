package com.sias.crm.workbeach.web.controller;

import com.sias.crm.settings.domain.User;
import com.sias.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request){

        /*01.前面的是返回的数据*/
        List<User> users = userService.queryAllUser();
        /*02.把得到的数据放到作用域中
        *    然后页面去数据的时候，在从作用域中取出来*/
        request.setAttribute("users",users);
        return "workbench/activity/index";
    }
}
