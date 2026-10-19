package run.section04.select;

import model.dto.MenuCategory;
import model.dto.MenuDTO3;

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

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

public class Application2 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("조회할 메뉴 번호를 입력하세요 : ");
        int num = Integer.parseInt(sc.nextLine());

        Connection con = getConnection();
        PreparedStatement pstmt = null;

        Properties prop = new Properties();

        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu-query.xml"));
            String query = prop.getProperty("selectQuery");

            pstmt = con.prepareStatement(query);

            pstmt.setInt(1, num);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()) {
                MenuCategory category = new MenuCategory();
                category.setCategoryName(rset.getString("category_name"));

                MenuDTO3 menuDTO3 = new MenuDTO3(
                        rset.getInt("menu_code"),
                        rset.getString("menu_name"),
                        rset.getInt("menu_price"),
                        category,
                        rset.getString("orderable_status")
                );
                System.out.println(
                        "메뉴번호=" + menuDTO3.getCode()
                                + ", 메뉴명=" + menuDTO3.getName()
                                + ", 가격=" + menuDTO3.getPrice()
                                + ", 카테고리=" + menuDTO3.getCategory().getCategoryName()
                                + ", 주문가능여부=" + menuDTO3.getOrderableStatus()
                );
            }

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvalidPropertiesFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            close(pstmt);
            close(con);
        }
    }
}
