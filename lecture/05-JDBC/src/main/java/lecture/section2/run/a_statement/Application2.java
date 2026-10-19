package lecture.section2.run.a_statement;

import lecture.section2.common.JDBCTemplate;
import lecture.section2.model.MenuDTO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Application2 {
    public static void main(String[] args) {

        MenuDTO menuDTO = null;
        Connection con = JDBCTemplate.getConnection(); // 1. 커넥션 생성

        // Statement : 완성된 SQL 문자열을 실행
        Statement stmt = null; // 2. Statement 생성 (쿼리 생성용)
        // ResultSet : SQL의 결과를 행단위로 읽음
        ResultSet rset = null; // 3. ResultSet 생성 (결과 받을용)

        Scanner sc = new Scanner(System.in);

        System.out.print("조회할 메뉴 코드를 입력하세요 : ");
        String menuCod = sc.nextLine();

        try {
            stmt = con.createStatement();

            // 4. 쿼리작성
            String sql = "select * from tbl_menu where menu_code = '" + menuCod + "'";

            // 5. 쿼리 실행 (Statement) 결과는 ResultSet으로 받음
            rset = stmt.executeQuery(sql); // sql을 실행기킨 결과물을 ResultSet에 담기

            // 6. 실행 결과를 꺼내서 가공
            while (rset.next()/*다음 값이 있나?*/) {
                menuDTO = new MenuDTO(
                        rset.getInt("menu_code"), // 메뉴코드
                        rset.getString("menu_name"), // 메뉴이름
                        rset.getInt("menu_price"), // 메뉴가격
                        rset.getInt("category_code"), // 카테고리코드
                        rset.getString("orderable_status") // 주문 가능 상태
                );
            }
            System.out.println(menuDTO);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
