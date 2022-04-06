package com.sias.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Edgar
 * @create 2022-03-31 19:16
 * @faction:
 */

@Controller
public class WorkBeachIndexController {


    @RequestMapping("/workbench/index.do")
    public String index(){
        return "workbench/index";
    }
}
