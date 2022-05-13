package com.sias.crm.workbench.service.impl;

import com.sias.crm.workbench.domain.Activity;
import com.sias.crm.workbench.mapper.ActivityMapper;
import com.sias.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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

    /*2.实现分页查询数据
    *   查询的是数据列表*/
    @Override
    public List<Activity> queryActivityByConditionForPage(Map map) {
        return activityMapper.selectActivityByConditionForPage(map);
    }


    /*3.查询总的条数*/
    @Override
    public int queryActivityOfByCondition(Map map) {
        return activityMapper.selectCountOfActivityByCondition(map);
    }


    /*4.删除用户数据*/
    @Override
    public int deleteActivityByIds(String[] ids) {
        return activityMapper.deleteActivityByIds(ids);
    }

    /*5.根据条件去查询数据
    *
    *   目的是为了修改数据，页面上的数据不完整*/
    @Override
    public Activity queryActivityById(String id) {
        return activityMapper.selectActivityById(id);
    }


    /*6.保存修改市场活动的信息*/
    @Override
    public int saveEditActivity(Activity activity) {
        return activityMapper.updateActivity(activity);
    }


}
