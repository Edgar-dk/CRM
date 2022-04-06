package com.sias.crm.workbench.service.impl;

import com.sias.crm.workbench.domain.Activity;
import com.sias.crm.workbench.mapper.ActivityMapper;
import com.sias.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Edgar
 * @create 2022-04-04 13:49
 * @faction:
 */
@Service("activityService")
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    /*1.页面上增加数据，通过idea插入到数据库中*/
    @Override
    public int saveCreateActivity(Activity activity) {

        int i = activityMapper.insertActivity(activity);
        return i;
    }
}
