package com.sias.crm.commons.utils;

import java.util.UUID;

/**
 * @author Edgar
 * @create 2022-04-04 17:57
 * @faction:
 */
public class UUIDUtils {


    /*把uuid封装成一个工具类，使用的时候，直接调用，省去了繁琐的代码*/
    public static String getUUid(){

        /*1.分析：下面：直接一个类名点方法，获得是一个对象，需要把这个对象穿换成普通的字符串
        *        类型，所以使用toString，最后的一个是，用空格替换掉-*/
        return  UUID.randomUUID().toString().replaceAll("-","");
    }
}
