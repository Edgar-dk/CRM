package com.sias.crm.settings.mapper;

import com.sias.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    User selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Mar 28 20:44:05 CST 2022
     */
    int updateByPrimaryKey(User record);



    /*1.
    * 根据账户的密码和名称去查询*/
    User selectUserByLoginActAndPwd(Map map);


    /*2.查询所有的用户*/
    public List<User> selectAllUser();
}