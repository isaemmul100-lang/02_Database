package run.section04.select;

import model.dto.MenuDTO2;

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

public class Application {

    /*
     * 메뉴를 조회하는데, 메뉴 번호를 입력받고
     * 메뉴 이름, 가격, 카테고리 이름, 주문가능여부를 출력한다.
     *
     * model DTO를 추가 생성
     * (MenuDTO2와 CategoryDTO 생성 필요)
     * */
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
                MenuDTO2 menuDTO2 = new MenuDTO2(
                        rset.getInt("menu_code"),
                        rset.getString("menu_name"),
                        rset.getInt("menu_price"),
                        rset.getString("category_name"),
                        rset.getString("orderable_status")
                );
                System.out.println(menuDTO2);
            }

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvalidPropertiesFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(con);
        }
    }
}
