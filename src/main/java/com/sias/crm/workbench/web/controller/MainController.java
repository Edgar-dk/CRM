package com.sias.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Edgar
 * @create 2022-04-03 16:51
 * @faction:
 */

@Controller
public class MainController {

    @RequestMapping("/workbench/main/index.do")
    public String index(){
        return "workbench/main/index";
    }
}
