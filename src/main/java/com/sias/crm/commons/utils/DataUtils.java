package com.sias.crm.commons.utils;

import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Edgar
 * @create 2022-03-31 19:35
 * @faction:
 */


public class DataUtils {


    /*
    *
    * 对日期时间进行格式化，就是把这个日期的格式转换成其他的形式
    * 下面的是封装一些固定不变的内容，防止在逻辑性区域中，直接写下面代码的
    * 话，不好维护
    * */


    public static String formateDateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = sdf.format(date);
        return format;
    }
}
