package com.sias.crm.workbench.service;

import com.sias.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

/**
 * @author Edgar
 * @create 2022-04-04 13:49
 * @faction:
 */
public interface ActivityService {

    /*1.页面上加入的数据，通过
    *   idea插入到数据库中*/
    public int saveCreateActivity(Activity activity);

    /*2.把插入的数据查询出来（查询的是数据列表）
    *   并且实现分页查询的目的*/
    public List<Activity> queryActivityByConditionForPage(Map map);

    /*3.查询activity的总条数*/
    public int queryActivityOfByCondition(Map map);


    /*4.删除多个用户*/
    public int deleteActivityByIds(String [] ids);


    /*5.根据条件查询
    *
    *   查询的目的是为了修改数据
    *   页面上的数据不完整，需要从数据库中查询出来*/
    public Activity queryActivityById(String id);



    /*6.保存修改的市场活动信息*/
    int saveEditActivity(Activity activity);
 }
