package run.section02.update;

import model.dto.MenuDTO;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;
import java.util.Scanner;

import static common.JDBCTemplate.*;

public class Application2 {

    /*
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

        Connection con = getConnection();
        PreparedStatement pstmt = null;

        Properties prop = new Properties();

        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query = prop.getProperty("oneSelect");

            pstmt = con.prepareStatement(query);

            pstmt.setInt(1, num);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()) {
                MenuDTO menuDTO = new MenuDTO(
                        rset.getInt("menu_code"),
                        rset.getString("menu_name"),
                        rset.getInt("menu_price"),
                        rset.getInt("category_code"),
                        rset.getString("orderable_status")
                );
                System.out.println(menuDTO);
            }

        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }


        System.out.print("변경한 이름을 입력하세요 : ");
        String changeName = sc.nextLine();
        System.out.print("변경한 가격을 입력하세요 : ");
        int changePrice = Integer.parseInt(sc.nextLine());

        int result;
        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query = prop.getProperty("updateMenu");

            pstmt = con.prepareStatement(query);

            pstmt.setString(1, changeName);
            pstmt.setInt(2, changePrice);
            pstmt.setInt(3, num);

            result = pstmt.executeUpdate();

            System.out.println("result = " + result);

        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        } finally {
            close(pstmt);
            close(con);
        }

    }
}
