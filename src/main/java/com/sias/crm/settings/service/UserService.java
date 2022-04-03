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


    /*2.查询全部的数据*/
    List<User> queryAllUser();
}
