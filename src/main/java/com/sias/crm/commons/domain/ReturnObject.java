package com.sias.crm.commons.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Edgar
 * @create 2022-03-29 18:52
 * @faction:
 */

/*当前的类用来返回JSON字符串的,这时候可能有一个问题，map也可以使用
* 但是为什么在这里不使用呢，虽然map的使用方式很简单，但是在map的底层运行起来是
* 很慢的，因为他的底层是由数据和链表的方式组成的，所以在执行的时候，也是很慢的*/
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
public class ReturnObject {
    private String code;   //处理成功和获取失败的标记  1可能是成功，0可能是失败
    private String message;  //展示在页面的具体信息
    private Object retData;  //表示以后返回的数据类型暂时不知道
}
