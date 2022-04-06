package com.sias.crm.settings.service;

import com.sias.crm.settings.domain.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author Edgar
 * @create 2022-03-28 21:08
 * @faction:
 */
@Service
public interface UserService {

    /*1.按照id去查询数据*/
    User queryUserByLoginActAndPwd(Map map);


    /*2.查询全部的数据
    *   点击一个页面，把数据展示在页面上*/
    List<User> queryAllUser();
}
