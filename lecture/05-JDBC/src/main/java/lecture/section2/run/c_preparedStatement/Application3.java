package lecture.section2.run.c_preparedStatement;

import lecture.section2.model.MenuDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static lecture.section2.common.JDBCTemplate.*;

public class Application3 {
    public static void main(String[] args) {
         // 사용자에게 문자열을 입력받고
        // 해당 문자열이 포함된 메뉴 목록을 출력하는 프로그램
        // (like)
        Scanner sc = new Scanner(System.in);
        List<MenuDTO> menuList = new ArrayList<>();

        System.out.print("문자열을 입력하세요 : ");
        String menuKeyword = sc.nextLine();

        String query = "select * from tbl_menu where menu_name like concat('%', ?, '%')";

        try (
                Connection con = getConnection();
                PreparedStatement pstmt = con.prepareStatement(query);
                ) {
            pstmt.setString(1, menuKeyword);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()) {
                menuList.add(new MenuDTO(
                        rset.getInt("menu_code"),
                        rset.getString("menu_name"),
                        rset.getInt("menu_price"),
                        rset.getInt("category_code"),
                        rset.getString("orderable_status")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(!menuList.isEmpty()) {
            for (MenuDTO menu : menuList) {
                System.out.println(menu);
            }
        } else {
            System.out.println("조건에 맞는 메뉴가 없습니다.");
        }
    }
}
