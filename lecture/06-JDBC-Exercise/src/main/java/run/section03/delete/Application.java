package run.section03.delete;

import model.dto.MenuDTO;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import static common.JDBCTemplate.*;

public class Application {

    /*
    * 전체 메뉴를 보여주고,
    * 삭제할 메뉴의 번호를 입력받는다.
    * 삭제한다.
    * */
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        Connection con = getConnection();
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        Properties prop = new Properties();

        int result;
        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query1 = prop.getProperty("allSelect");
            String query2 = prop.getProperty("deleteMenu");

            pstmt1 = con.prepareStatement(query1);
            pstmt2 = con.prepareStatement(query2);

            ResultSet rset = pstmt1.executeQuery();

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


        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        System.out.print("삭제할 메뉴의 번호를 입력하세요 : ");
        int num = Integer.parseInt(sc.nextLine());

        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query = prop.getProperty("deleteMenu");

            pstmt2 = con.prepareStatement(query);

            pstmt2.setInt(1, num);

            result = pstmt2.executeUpdate();

            System.out.println("result = " + result);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvalidPropertiesFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            close(pstmt1);
            close(pstmt2);
            close(con);
        }
    }
}
