package com.sias.crm.settings.service.Impl;

import com.sias.crm.settings.domain.User;
import com.sias.crm.settings.mapper.UserMapper;
import com.sias.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author Edgar
 * @create 2022-03-28 21:08
 * @faction:
 */
@Service("userService")
public  class UserServiceImpl implements UserService {

    /*1.把这个接口注入进来*/
    @Autowired
    private UserMapper userMapper;

    /*2.按照id去查询数据*/
    @Override
    public User queryUserByLoginActAndPwd(Map map) {
        User user = userMapper.selectUserByLoginActAndPwd(map);
        return user;
    }

    /*2.查询全部的数据
    *   点击一个页面，把数据展示在页面上*/
    @Override
    public List<User> queryAllUser() {
        return userMapper.selectAllUser();
    }
}
