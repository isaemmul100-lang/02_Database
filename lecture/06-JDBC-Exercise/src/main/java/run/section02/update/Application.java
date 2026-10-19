package run.section02.update;

import model.dto.MenuDTO;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;
import java.util.Scanner;

import static common.JDBCTemplate.*;

public class Application {

    /*
    * 1. 메뉴 변경하기
    * 변경할 메뉴 번호를 입력받고
    *
    * 해당 메뉴의 변경사항을 입력받는다.
    * (메뉴이름, 메뉴가격)
    * 메뉴를 변경한다.
    *
    * 2. 변경할 메뉴 번호를 입력하면 현재 메뉴 정보가 보이고 메뉴의 변경사항을 입력받는다.
    * */

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("변경할 메뉴의 번호를 입력하세요 : ");
        int num = Integer.parseInt(sc.nextLine());
        System.out.print("새로운 메뉴 이름을 입력하세요 : ");
        String changeName = sc.nextLine();
        System.out.print("새로운 메뉴의 가격을 입력하세요 : ");
        int changePrice = Integer.parseInt(sc.nextLine());

        Connection con = getConnection();
        PreparedStatement pstmt = null;

        MenuDTO menuDTO = new MenuDTO();
        menuDTO.getCode();

        Properties prop = new Properties();

        int result;

        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query = prop.getProperty("updateMenu");

            pstmt = con.prepareStatement(query);

            pstmt.setString(1, changeName);
            pstmt.setInt(2, changePrice);
            pstmt.setInt(3, num);

            result = pstmt.executeUpdate();

        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(pstmt);
            close(con);
        }
        System.out.println("result = " + result);
    }
}
