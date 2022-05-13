package com.sias.crm.poi;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * @author Edgar
 * @create 2022-05-13 20:37
 * @faction:
 */
public class CreateExcelTest {


    public static void main(String[] args) throws IOException {
        /*1.文件：创建一个Excel文件对象*/
        HSSFWorkbook sheets = new HSSFWorkbook();

        /*2.表：在用创建好的文件去创建一张表对象
        *
        *   后面的参数，是这张表的名字*/
        HSSFSheet sheet = sheets.createSheet("学生列表");


        /*3.行：用这张表去增加行
        *
        *   0表示从第一行开始*/
        HSSFRow row = sheet.createRow(0);


        /*4.列：列是在行的基础上增加的，因此，创建的过程
        *
        *   下面创建的是最上面的名字
        *
        *
        *   也是通过行（对象）来完成的
        *   参数表示从第一列开始
        *   在去设置这一列的数据上，直接在
        *   最上面写上对应的数据类型即可，例如
        *   下面写的是汉字，表示存放的是String
        *   类型的数据，写数字的话，表示存放int
        *   类型的数据，*/
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("学号");

        cell = row.createCell(1);
        cell.setCellValue("姓名");

        cell = row.createCell(2);
        cell.setCellValue("年龄");



        /*5.使用循环的方式去创建行和列*/
        for(int i=1;i<=10;i++){
            row = sheet.createRow(i);

            cell = row.createCell(0);
            cell.setCellValue(100+i);

            cell = row.createCell(1);
            cell.setCellValue("NAME"+i);

            cell = row.createCell(2);
            cell.setCellValue(20+i);
        }

        /*6.把写好的文件写入到指定
        *   位置上*/
        FileOutputStream outputStream = new FileOutputStream("D:\\User1\\rundata\\document\\major\\UnderASophomore\\idea\\Project\\Test\\studentList.xls");
        sheets.write(outputStream);


        /*7.关闭资源*/
        outputStream.close();
        sheets.close();

        System.out.println("++++++++++============++++++");
    }
}
