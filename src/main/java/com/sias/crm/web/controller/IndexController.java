package com.sias.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Edgar
 * @create 2022-03-27 16:55
 * @faction:
 */

@Controller
public class IndexController {

    @RequestMapping("/")
    public String  index(){
        /*01.请求转发*/
        return "index";
    }
}
