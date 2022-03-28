package com.sias.crm.settings.service;

import com.sias.crm.settings.domain.User;

import java.util.Map;

/**
 * @author Edgar
 * @create 2022-03-28 21:08
 * @faction:
 */
public interface UserService {
    User queryUserByLoginActAndPwd(Map map);
}
