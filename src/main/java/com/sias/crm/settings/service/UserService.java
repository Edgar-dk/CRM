package com.sias.crm.settings.service;

import com.sias.crm.settings.domain.User;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author Edgar
 * @create 2022-03-28 21:08
 * @faction:
 */
@Service
public interface UserService {
    User queryUserByLoginActAndPwd(Map map);
}
